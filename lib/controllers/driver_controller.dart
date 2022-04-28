import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cphflyt/models/address_model.dart';
import 'package:cphflyt/models/document_model.dart';
import 'package:cphflyt/models/request_model.dart';
import 'package:cphflyt/services/database_service.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

import 'filter_controller.dart';

class DriverController {

  // Future<QuerySnapshot<Map<String, dynamic>>> getRequests(String driverID) {
  //   _sortRequests(driverID);
  //   return DatabaseService().getRequestsAsDriver(driverID);
  // }

  Future<List<Document>> getRequests(String driverID) async {

    List<Document> returnList = [];

    var sub = await DatabaseService().getRequestsAsDriver(driverID);
    var data = sub.docs;

    Position currentPosition = await Geolocator.getCurrentPosition();

    for (var element in data) {
      Map doc = element.data();

      List<Location> locations = await locationFromAddress("${doc['fromAddress']} ${doc['fromZip']} ${doc['fromBy']}");
      double distanceInMeters = 999999999999999;

      if (locations.isNotEmpty) {
        distanceInMeters = Geolocator.distanceBetween(currentPosition.latitude, currentPosition.longitude, locations[0].latitude, locations[0].longitude);
      }

      doc['distance'] = distanceInMeters;
      returnList.add(Document(element.id, doc));
    }

    returnList.sort((m1, m2) {
      var r = m1.data["distance"].compareTo(m2.data["distance"]);
      if (r != 0) return r;
      return m1.data["distance"].compareTo(m2.data["distance"]);
    });

    return returnList;
  }

  redirectToGoogleMaps (AddressModel address) async {
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
      date: "${doc.data['dateDay']}.${doc.data['dateMonth']} ${doc.data['dateYear']}",
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
      status: doc.data['status']=='pending'?Filter.Pending:doc.data["status"]=='approved'?Filter.Approved:Filter.Trash,
    );

    return requestModel;
  }

}