import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cphflyt/models/address_model.dart';
import 'package:cphflyt/models/completion_model.dart';
import 'package:cphflyt/models/document_model.dart';
import 'package:cphflyt/models/request_model.dart';
import 'package:cphflyt/screens/driver_home.dart';
import 'package:cphflyt/services/database_service.dart';
import 'package:cphflyt/services/storage_service.dart';
import 'package:cphflyt/widgets/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cphflyt/controllers/filter_controller.dart';

class DriverController {
  Future<Position?> _getPosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ToastBar(text: 'Location services are disabled.', color: Colors.red)
          .show();
      return null;
    } else {
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          ToastBar(text: 'Location permissions are denied', color: Colors.red)
              .show();
          return null;
        }
      } else if (permission == LocationPermission.deniedForever) {
        ToastBar(
                text:
                    'Location permissions are permanently denied. Please go to application setting and give the location permission to the app.',
                color: Colors.red)
            .show();
        return null;
      }

      return await Geolocator.getCurrentPosition();
    }
  }

  Future<List<Document>> getRequests(String driverID) async {
    List<Document> tasksList = [];

    var sub = await DatabaseService().getRequestsAsDriver(driverID);
    var data = sub.docs;

    Position? currentPosition = await _getPosition();

    for (var element in data) {
      Map doc = element.data();

      List<Location> locations = [];
      try {
        locations = await locationFromAddress(
            "${doc['fromAddress']} ${doc['fromZip']} ${doc['fromBy']}");
      } catch (e) {
        print("error " + e.toString());
      }

      double distanceInMeters = 999999999999999;

      if (locations.isNotEmpty && currentPosition != null) {
        distanceInMeters = Geolocator.distanceBetween(
            currentPosition.latitude,
            currentPosition.longitude,
            locations[0].latitude,
            locations[0].longitude);
      }

      doc['distance'] = distanceInMeters;
      tasksList.add(Document(element.id, doc));
    }

    //sorting
    tasksList.sort((m1, m2) {
      var r = m1.data["distance"].compareTo(m2.data["distance"]);
      if (r != 0) return r;
      return m1.data["distance"].compareTo(m2.data["distance"]);
    });

    return tasksList;
  }

  redirectToGoogleMaps(AddressModel address) async {
    Uri url = Uri.parse(
        "https://www.google.com/maps/search/?api=1&query=${address.addressJoined}");
    await launchUrl(url, mode: LaunchMode.externalNonBrowserApplication);
  }

  RequestModel createRequestFromJson(Document doc) {
    RequestModel requestModel = RequestModel(
      id: doc.id,
      firstName: doc.data['firstName'],
      lastName: doc.data['lastName'],
      telePhone: doc.data['phone'],
      email: doc.data['email'],
      type: doc.data['type'],
      packageType: doc.data['package'],
      date:
          "${doc.data['dateDay']}. ${doc.data['dateMonth']} ${doc.data['dateYear']}",
      flexible: doc.data['flexible'],
      isPacking: doc.data['isUnpack'] == 'Ja',
      isCleaning: doc.data['isCleaning'] == 'Ja',
      isHeavy: doc.data['isHeavy'] == 'Ja',
      isBreakable: doc.data['isBreakable'] == 'Ja',
      others: doc.data.containsKey("other") ? doc.data['other'] : "",
      breakCount: doc.data.containsKey("breakableCount")
          ? doc.data['breakableCount']
          : "0",
      heavyCount:
          doc.data.containsKey("heavyCount") ? doc.data['heavyCount'] : "0",
      fromAddress: AddressModel(
          doc.data['fromAddress'], doc.data['fromZip'], doc.data['fromBy']),
      toAddress: AddressModel(
          doc.data['toAddress'], doc.data['toZip'], doc.data['toBy']),
      status: doc.data['status'] == 'pending'
          ? Filter.Pending
          : doc.data["status"] == 'approved'
              ? Filter.Approved
              : Filter.Trash,
    );

    return requestModel;
  }

  completeTask(
      {required Uint8List customerSign,
      required String customerName,
      required String driverName,
      required List<File?> images,
      required String taskID,
      required String given,
      required String startTime,
      required String endTime,
      required String hourlyRate,
      required String numOfHours,
      required String paymentType,
      required String heavyLifting,
      required String garbage,
      required String storage,
      required String total,
      required BuildContext context}) async {
    SimpleFontelicoProgressDialog pd = SimpleFontelicoProgressDialog(
        context: context, barrierDimisable: false);
    pd.show(
      message: "Data uploading...",
      indicatorColor: Theme.of(context).primaryColor,
      width: 0.6.sw,
      height: 100.h,
      textAlign: TextAlign.center,
      separation: 30.h,
    );

    try {
      StorageService storageService = StorageService();
      String customerSignature = await storageService.uploadBytes(
          customerName.replaceAll(' ', '_'), customerSign);
      pd.updateMessageText("Customer Signature Uploaded...");

      List<String> imageUrls = List.filled(images.length, "", growable: false);

      for (int i = 0; i < images.length; i++) {
        if (images[i] != null) {
          String url =
              await storageService.uploadFile(i.toString(), taskID, images[i]!);
          pd.updateMessageText("Image ${i + 1} Uploaded...");
          imageUrls[i] = url;
        }
      }

      CompleteTask completeTask = CompleteTask(
          taskId: taskID,
          given: given,
          startTime: startTime,
          endTime: endTime,
          hourlyRate: hourlyRate,
          numberOfHours: numOfHours,
          paymentType: paymentType,
          garbage: garbage,
          heavyLifting: heavyLifting,
          storage: storage,
          total: total,
          image1: imageUrls[0],
          image2: imageUrls[1],
          image3: imageUrls[2],
          image4: imageUrls[3],
          image5: imageUrls[4],
          image6: imageUrls[5],
          image7: imageUrls[6],
          image8: imageUrls[7],
          driverName: driverName,
          customerName: customerName,
          customerSign: customerSignature);

      await DatabaseService().completeTask(completeTask);

      pd.hide();
      ToastBar(text: "Task is mark as completed!", color: Colors.green).show();

      Navigator.of(context).pushAndRemoveUntil(
          CupertinoPageRoute(builder: (context) => DriverHome()),
          (Route<dynamic> route) => false);
    } catch (e) {
      pd.hide();
      ToastBar(text: e.toString(), color: Colors.red).show();
    }
  }

  Future<CompleteTask> getCompletedTask(String id) async {
    var dbService = DatabaseService();
    DocumentSnapshot document = await dbService.getCompletedTask(id);
    return dbService.createCompleteTaskFromJson(document.data(), id);
  }
}
