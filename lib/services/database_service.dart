import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cphflyt/controllers/bottom_nav_controller.dart';
import 'package:cphflyt/controllers/filter_controller.dart';
import 'package:cphflyt/models/address_model.dart';
import 'package:cphflyt/models/driver_model.dart';
import 'package:cphflyt/models/employee_model.dart';
import 'package:cphflyt/models/request_model.dart';
import 'package:cphflyt/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

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
          others: doc.data().containsKey("other") ? doc['other'] : "",
          breakCount: doc.data().containsKey("breakableCount") ? doc['breakableCount'] : "0",
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

  Future<bool> addEmployee(Employee employee) async {
    try{
      await _firestore.collection('admins').doc(employee.uid).set({
        'email': employee.email,
        'name': employee.name,
        'id': employee.uid,
        'role': 'admin',
        'page': employee.page == Nav.Website? 'website' : 'manual'
      });

      ToastBar(text: "Employee Successfully added!", color: Colors.green).show();
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

  addRequest(RequestModel request) async {

    await initializeDateFormatting('da_DK');
    DateTime parsedDate = DateTime.parse(request.date);

    await _firestore.collection('requests').add({
      'firstName': request.firstName,
      'lastName': request.lastName,
      'phone': request.telePhone,
      'email': request.email,
      'type': request.type,
      'package': request.packageType,
      'dateDay': parsedDate.day,
      'dateMonth': DateFormat('MMMM', 'da_DK').format(parsedDate),
      'dateYear': parsedDate.year,
      'fromAddress': request.fromAddress.address,
      'fromZip': request.fromAddress.zip,
      'fromBy': request.fromAddress.by,
      'toAddress': request.toAddress.address,
      'toZip': request.toAddress.zip,
      'toBy': request.toAddress.by,
      'flexible': request.flexible,
      'isUnpack': request.isPacking?'Ja':'Nej',
      'isCleaning': request.isCleaning?'Ja':'Nej',
      'isHeavy': request.isHeavy?'Ja':'Nej',
      'heavyCount': request.heavyCount,
      'isBreakable': request.isBreakable?'Ja':'Nej',
      'breakableCount': request.breakCount,
      'other': request.others,
      'status': 'pending',
      'from': 'manual'
    });
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDataFromFirebase(String id) async {
    return await _firestore.collection('admins').doc(id).get();
  }

}
