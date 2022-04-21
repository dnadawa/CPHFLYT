import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cphflyt/controllers/bottom_nav_controller.dart';
import 'package:cphflyt/controllers/filter_controller.dart';
import 'package:cphflyt/models/address_model.dart';
import 'package:cphflyt/models/driver_model.dart';
import 'package:cphflyt/models/request_model.dart';
import 'package:cphflyt/widgets/toast.dart';
import 'package:flutter/material.dart';

class DatabaseService extends ChangeNotifier{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> getRequests({Filter filter = Filter.Pending, Nav from = Nav.Website}) {
    if (filter == Filter.Pending && from == Nav.Website){
      return _firestore.collection('requests').where('status', isEqualTo: 'pending').where('from', isEqualTo: 'website').snapshots();
    }
    else if (filter == Filter.Pending && from == Nav.Manual){
      return _firestore.collection('requests').where('status', isEqualTo: 'pending').where('from', isEqualTo: 'manual').snapshots();
    }
    else if (filter == Filter.Approved && from == Nav.Website){
      return _firestore.collection('requests').where('status', isEqualTo: 'approved').where('from', isEqualTo: 'website').snapshots();
    }
    else if (filter == Filter.Approved && from == Nav.Manual){
      return _firestore.collection('requests').where('status', isEqualTo: 'approved').where('from', isEqualTo: 'manual').snapshots();
    }
    else if (filter == Filter.Trash && from == Nav.Website){
      return _firestore.collection('requests').where('status', isEqualTo: 'trash').where('from', isEqualTo: 'website').snapshots();
    }
    else if (filter == Filter.Trash && from == Nav.Manual){
      return _firestore.collection('requests').where('status', isEqualTo: 'trash').where('from', isEqualTo: 'manual').snapshots();
    }
    else {
      return _firestore.collection('requests').snapshots();
    }
  }

  RequestModel createRequestFromJson(var doc) {
      RequestModel requestModel = RequestModel(
          id: doc.id,
          firstName: doc['firstName'],
          lastName: doc['lastName'],
          telePhone: doc['phone'],
          email: doc['email'],
          type: doc['type'],
          packageType: doc['package'],
          date: "${doc['dateDay']}.${doc['dateMonth']} ${doc['dateYear']}",
          flexible: doc['flexible'],
          isPacking: doc['isUnpack'] == 'Ja',
          isCleaning: doc['isCleaning'] == 'Ja',
          isHeavy: doc['isHeavy'] == 'Ja',
          isBreakable: doc['isBreakable'] == 'Ja',
          others: doc.data().containsKey("others") ? doc['others'] : "",
          breakCount: doc.data().containsKey("breakCount") ? doc['breakCount'] : "0",
          heavyCount: doc.data().containsKey("heavyCount") ? doc['heavyCount'] : "0",
          fromAddress: AddressModel(doc['fromAddress'], doc['fromZip'], doc['fromBy']),
          toAddress: AddressModel(doc['toAddress'], doc['toZip'], doc['toBy']),
          status: doc['status']=='pending'?Filter.Pending:doc["status"]=='approved'?Filter.Approved:Filter.Trash,
      );

      return requestModel;
  }

  Future<bool> addDriver(Driver driver) async {
    try{
      await _firestore.collection('drivers').doc(driver.uid).set({
        'email': driver.email,
        'name': driver.name,
        'id': driver.uid
      });

      ToastBar(text: "Driver Successfully added!", color: Colors.green).show();
      return true;
    }
    catch(e){
      ToastBar(text: e.toString(), color: Colors.red).show();
      return false;
    }
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getDrivers() async {
    var sub = await _firestore.collection('drivers').get();
    return sub.docs;
  }

  assignDriver(String? uid, String requestID) async {
    await _firestore.collection('requests').doc(requestID).update({
      'driver': uid,
      'status': 'approved'
    });
  }

  trashRequest(String requestID) async {
    await _firestore.collection('requests').doc(requestID).update({
      'status': 'trash'
    });
  }

}
