import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cphflyt/models/address_model.dart';
import 'package:cphflyt/models/completion_model.dart';
import 'package:cphflyt/models/document_model.dart';
import 'package:cphflyt/models/request_model.dart';
import 'package:cphflyt/screens/driver_home.dart';
import 'package:cphflyt/services/database_service.dart';
import 'package:cphflyt/services/email_service.dart';
import 'package:cphflyt/services/storage_service.dart';
import 'package:cphflyt/widgets/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cphflyt/controllers/filter_controller.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class DriverController {
  Future<Position?> _getPosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ToastBar(text: 'Location services are disabled.', color: Colors.red).show();
      return null;
    } else {
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          ToastBar(text: 'Location permissions are denied', color: Colors.red).show();
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
        locations =
            await locationFromAddress("${doc['fromAddress']} ${doc['fromZip']} ${doc['fromBy']}");
      } catch (e) {
        print("error " + e.toString());
      }

      double distanceInMeters = 999999999999999;

      if (locations.isNotEmpty && currentPosition != null) {
        distanceInMeters = Geolocator.distanceBetween(currentPosition.latitude,
            currentPosition.longitude, locations[0].latitude, locations[0].longitude);
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
    Uri url = Uri.parse("https://www.google.com/maps/search/?api=1&query=${address.addressJoined}");
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
      date: "${doc.data['dateDay']}. ${doc.data['dateMonth']} ${doc.data['dateYear']}",
      flexible: doc.data['flexible'],
      isPacking: doc.data['isUnpack'] == 'Ja',
      isCleaning: doc.data['isCleaning'] == 'Ja',
      isHeavy: doc.data['isHeavy'] == 'Ja',
      isBreakable: doc.data['isBreakable'] == 'Ja',
      others: doc.data.containsKey("other") ? doc.data['other'] : "",
      breakCount: doc.data.containsKey("breakableCount") ? doc.data['breakableCount'] : "0",
      heavyCount: doc.data.containsKey("heavyCount") ? doc.data['heavyCount'] : "0",
      fromAddress: AddressModel(doc.data['fromAddress'], doc.data['fromZip'], doc.data['fromBy']),
      toAddress: AddressModel(doc.data['toAddress'], doc.data['toZip'], doc.data['toBy']),
      status: doc.data['status'] == 'pending'
          ? Filter.Pending
          : doc.data["status"] == 'approved'
              ? Filter.Approved
              : Filter.Trash,
    );

    return requestModel;
  }

  Future<File> generatePDF(CompleteTask completedTask, List<File?> attachments, Uint8List signature,
      RequestModel request) async {
    final pdf = pw.Document();

    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Task #${completedTask.taskId}',
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 20),
              ),
              pw.SizedBox(height: 15),
              pw.Text('Fornavn: \t${request.firstName}', textAlign: pw.TextAlign.left),
              pw.SizedBox(height: 5),
              pw.Text('Efternavn: \t${request.lastName}', textAlign: pw.TextAlign.left),
              pw.SizedBox(height: 5),
              pw.Text('Tlf.Nr.: \t${request.telePhone}', textAlign: pw.TextAlign.left),
              pw.SizedBox(height: 5),
              pw.Text('Mail: \t${request.email}', textAlign: pw.TextAlign.left),
              pw.SizedBox(height: 5),
              pw.Text('Privat eller erhverv?: \t${request.type}', textAlign: pw.TextAlign.left),
              pw.SizedBox(height: 5),
              pw.Text('Hvilken pakke ønsker du tilbud på?: \t${request.packageType}', textAlign: pw.TextAlign.left),
              pw.SizedBox(height: 5),
              pw.Text('Hvornår skal du flytte?: \t${request.date}', textAlign: pw.TextAlign.left),
              pw.SizedBox(height: 5),
              pw.Text('Hvor skal du flytte fra?: \t${request.fromAddress.addressJoined}', textAlign: pw.TextAlign.left),
              pw.SizedBox(height: 5),
              pw.Text('Hvor skal du flytte til? : \t${request.toAddress.addressJoined}', textAlign: pw.TextAlign.left),
              pw.SizedBox(height: 5),
              pw.Text('Er flyttedagen fleksibel? : \t${request.flexible}', textAlign: pw.TextAlign.left),
              pw.SizedBox(height: 5),
              pw.Text('Skal flyttefirmaet stå for nedpakning af dine ting?: \t${request.isPacking ? 'Ja': 'Nej'}',
                  textAlign: pw.TextAlign.left),
              pw.SizedBox(height: 5),
              pw.Text('Vil du have flytterengøring i din nuværende bolig?: \t${request.isCleaning ? 'Ja': 'Nej'}',
                  textAlign: pw.TextAlign.left),
              pw.SizedBox(height: 5),
              pw.Text('Skal der flyttes særligt tungt inventar?: \t${request.isHeavy ? 'Ja': 'Nej'}',
                  textAlign: pw.TextAlign.left),
              pw.SizedBox(height: 5),
              pw.Text('Hvis ja, hvor meget?: \t${request.heavyCount}', textAlign: pw.TextAlign.left),
              pw.SizedBox(height: 5),
              pw.Text('Skal der flyttes inventar som nemt kan gå i stykker?: \t${request.isBreakable ? 'Ja': 'Nej'}',
                  textAlign: pw.TextAlign.left),
              pw.SizedBox(height: 5),
              pw.Text('Hvis ja, hvor meget?: \t${request.breakCount}', textAlign: pw.TextAlign.left),
              pw.SizedBox(height: 5),
              pw.Text('Andre bemærkninger: \t${request.others}', textAlign: pw.TextAlign.left),
              pw.SizedBox(height: 40),
              pw.Text(
                'Completed Details',
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 20),
              ),
              pw.SizedBox(height: 15),
              pw.Text('Dato: \t${completedTask.given}', textAlign: pw.TextAlign.left),
              pw.SizedBox(height: 5),
              pw.Text('Start tidspunkt: \t${completedTask.startTime}',
                  textAlign: pw.TextAlign.left),
              pw.SizedBox(height: 5),
              pw.Text('Slut tidspunkt: \t${completedTask.endTime}', textAlign: pw.TextAlign.left),
              pw.SizedBox(height: 5),
              pw.Text('Timepris: \t${completedTask.hourlyRate}', textAlign: pw.TextAlign.left),
              pw.SizedBox(height: 5),
              pw.Text('Antal timer: \t${completedTask.numberOfHours}',
                  textAlign: pw.TextAlign.left),
              pw.SizedBox(height: 5),
              pw.Text('Betalingstype: \t${completedTask.paymentType}',
                  textAlign: pw.TextAlign.left),
              pw.SizedBox(height: 5),
              pw.Text('Tungløft: \t${completedTask.heavyLifting}', textAlign: pw.TextAlign.left),
              pw.SizedBox(height: 5),
              pw.Text('Skrald: \t${completedTask.garbage}', textAlign: pw.TextAlign.left),
              pw.SizedBox(height: 5),
              pw.Text('Opbevaring: \t${completedTask.storage}', textAlign: pw.TextAlign.left),
              pw.SizedBox(height: 5),
              pw.Text('Samlet beløb: \t${completedTask.total}', textAlign: pw.TextAlign.left),
              pw.SizedBox(height: 5),
              pw.Text('Medarbejders Navn: \t${completedTask.driverName}',
                  textAlign: pw.TextAlign.left),
              pw.SizedBox(height: 5),
              pw.Text('Kundens Navn: \t${completedTask.customerName}',
                  textAlign: pw.TextAlign.left),
            ],
          );
        }));


    pdf.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context){
        return pw.Column(
          mainAxisAlignment: pw.MainAxisAlignment.center,
          children: [
            pw.Text('Kundens Underskrift', textAlign: pw.TextAlign.center, style: pw.TextStyle(fontSize: 20)),
            pw.SizedBox(height: 30),
            pw.Center(
              child: pw.Image(pw.MemoryImage(signature), height: 450, fit: pw.BoxFit.contain),
            ),
          ]
        );
      }
    ));


    List<pw.Widget> gridItems = [];

    for (int i = 0; i < attachments.length; i++) {
      if (attachments[i] != null) {
        gridItems.add(pw.Column(children: [
          pw.Text('Vedhæft ${i + 1}', textAlign: pw.TextAlign.center),
          pw.SizedBox(height: 20),
          pw.Center(
              child: pw.Image(pw.MemoryImage(attachments[i]!.readAsBytesSync()),
                  height: 200, width: 230, fit: pw.BoxFit.contain)),
        ]));
      }
    }

    if (gridItems.isNotEmpty){
      pdf.addPage(pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Center(
              child: pw.GridView(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  mainAxisSpacing: 80,
                  children: gridItems.take(4).toList()
              )
            );
            // return pw.Column(children: gridItems);
          }));
    }

    if (gridItems.length > 4){
      pdf.addPage(pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Center(
              child: pw.GridView(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  mainAxisSpacing: 80,
                  children: gridItems.skip(4).take(4).toList()
              )
            );
            // return pw.Column(children: gridItems);
          }));
    }


    final output = await getApplicationDocumentsDirectory();
    final file = File("${output.path}/tempDriverReport.pdf");
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  void completeTask({
    required Uint8List customerSign,
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
    required BuildContext context,
    required RequestModel request,
  }) async {
    SimpleFontelicoProgressDialog pd =
        SimpleFontelicoProgressDialog(context: context, barrierDimisable: false);
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
      String customerSignature =
      await storageService.uploadBytes(customerName.replaceAll(' ', '_'), customerSign);
      pd.updateMessageText("Customer Signature Uploaded...");

      List<String> imageUrls = List.filled(images.length, "", growable: false);

      for (int i = 0; i < images.length; i++) {
        if (images[i] != null) {
          String url = await storageService.uploadFile(i.toString(), taskID, images[i]!);
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
        customerSign: customerSignature,
      );

      pd.updateMessageText("Finishing up...");

      await DatabaseService().completeTask(completeTask);

      File pdf = await generatePDF(completeTask, images, customerSign, request);
      String url = await storageService.uploadFile('', taskID, pdf, isPdf: true);
      await EmailService().sendEmail(request.email, url);
      pd.hide();
      ToastBar(text: "Task is mark as completed!", color: Colors.green).show();

      Navigator.of(context).pushAndRemoveUntil(
          CupertinoPageRoute(builder: (context) => DriverHome()), (Route<dynamic> route) => false);
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
