import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cphflyt/controllers/bottom_nav_controller.dart';
import 'package:cphflyt/controllers/filter_controller.dart';
import 'package:cphflyt/models/address_model.dart';
import 'package:cphflyt/models/completion_model.dart';
import 'package:cphflyt/models/driver_model.dart';
import 'package:cphflyt/models/employee_model.dart';
import 'package:cphflyt/models/request_model.dart';
import 'package:cphflyt/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:cphflyt/constants.dart';

class DatabaseService extends ChangeNotifier{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String _searchText = "";

  set searchText(String text){
    _searchText = text.trim().toLowerCase();
    notifyListeners();
  }

  getRequests({Filter filter = Filter.Pending, Nav from = Nav.Website,CompletedFilter completedFilter = CompletedFilter.All, List<DateTime>? dateFilter}) {
    Query query = _firestore.collection('requests');

    ///filter
    if (filter == Filter.Pending){
      query = query.where('status', isEqualTo: 'pending');
    }
    else if (filter == Filter.Approved){
      if (completedFilter == CompletedFilter.All){
        query = query.where('status', isEqualTo: 'approved');
      }
      else if(completedFilter == CompletedFilter.Completed){
        query = query.where('status', isEqualTo: 'approved').where('isCompleted', isEqualTo: true);
      }
      else{
        query = query.where('status', isEqualTo: 'approved').where('isCompleted', isEqualTo: false);
      }

    }
    else if (filter == Filter.Trash){
      query = query.where('status', isEqualTo: 'trash');
    }

    ///search
    if (_searchText.isNotEmpty){
      query = query.where('email', isEqualTo: _searchText);
    }

    ///nav
    if(from == Nav.Website){
      query = query.where('from', isEqualTo: 'website');
    }
    else{
      query = query.where('from', isEqualTo: 'manual');
    }

    ///date filter
    if(dateFilter != null){
      List<String> dates = dateFilter.map((e) => e.year.toString() + '-' + capitalize(DateFormat.MMMM('da_DK').format(e)) + '-' + e.day.toString()).toList();
      query = query
          .where('dateFull', whereIn: dates);
    }

    return query.where('idChanged', isEqualTo: 'true').snapshots();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getRequestsAsDriver(String driverID) {
    return _firestore.collection('requests').where('driver', isEqualTo: driverID).where('isCompleted', isEqualTo: false).get();
  }

  emptyTrash(Nav type) async {
    QuerySnapshot<Map<String, dynamic>> sub;
    if (type == Nav.Website){
      sub = await _firestore.collection('requests').where('status', isEqualTo: 'trash').where('from', isEqualTo: 'website').get();
    }
    else{
      sub = await _firestore.collection('requests').where('status', isEqualTo: 'trash').where('from', isEqualTo: 'manual').get();
    }
    for (var document in sub.docs) {
      await _firestore.collection('requests').doc(document.id).delete();
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
          date: "${doc['dateDay']}. ${doc['dateMonth']} ${doc['dateYear']}",
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
          driver: doc.data().containsKey("driver") ? doc['driver'] : "",
          isCompleted: doc.data().containsKey("isCompleted") ? doc['isCompleted'] : false
      );

      return requestModel;
  }

  CompleteTask createCompleteTaskFromJson(var doc, String taskID) {
    CompleteTask completeTask = CompleteTask(
        customerName: doc['customerName'],
        customerSign: doc['customerSign'],
        driverName: doc['driverName'],
        endTime: doc['endTime'],
        garbage: doc['garbage'],
        given: doc['given'],
        heavyLifting: doc['heavyLifting'],
        hourlyRate: doc['hourlyRate'],
        image1: doc['image1'],
        image2: doc['image2'],
        image3: doc['image3'],
        image4: doc['image4'],
        image5: doc['image5'],
        image6: doc['image6'],
        image7: doc['image7'],
        image8: doc['image8'],
        numberOfHours: doc['numberOfHours'],
        paymentType: doc['paymentType'],
        startTime: doc['startTime'],
        storage: doc['storage'],
        total: doc['total'],
        taskId: taskID
    );

    return completeTask;
  }


  Future<bool> addDriver(Driver driver) async {
    try{
      await _firestore.collection('drivers').doc(driver.uid).set({
        'email': driver.email,
        'phone': driver.phone,
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
        'phone': employee.phone,
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

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getEmployees() async {
    var sub = await _firestore.collection('admins').where('role', isEqualTo: 'admin').get();
    return sub.docs;
  }

  assignDriver(String? uid, String requestID) async {
    await _firestore.collection('requests').doc(requestID).update({
      'driver': uid,
      'status': 'approved',
      'isCompleted': false
    });
  }

  trashRequest(String requestID) async {
    await _firestore.collection('requests').doc(requestID).update({
      'status': 'trash'
    });
  }

  addRequest(RequestModel request) async {
    await initializeDateFormatting('da_DK');
    DateTime parsedDate = DateFormat.yMMMMd('da_DK').parse(request.date);

    await _firestore.collection('requests').add({
      'firstName': request.firstName,
      'lastName': request.lastName,
      'phone': request.telePhone,
      'email': request.email,
      'type': request.type,
      'package': request.packageType,
      'dateDay': parsedDate.day,
      'dateMonth': capitalize(DateFormat('MMMM', 'da_DK').format(parsedDate)),
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
      'from': 'manual',
      'idChanged': 'false'
    });
  }

  editRequest(RequestModel request) async {
    await initializeDateFormatting('da_DK');
    DateTime parsedDate = DateFormat.yMMMMd('da_DK').parse(request.date);

    await _firestore.collection('requests').doc(request.id).update({
      'firstName': request.firstName,
      'lastName': request.lastName,
      'phone': request.telePhone,
      'email': request.email,
      'type': request.type,
      'package': request.packageType,
      'dateDay': parsedDate.day,
      'dateMonth': capitalize(DateFormat('MMMM', 'da_DK').format(parsedDate)),
      'dateYear': parsedDate.year,
      'dateFull': "${parsedDate.year}-${capitalize(DateFormat('MMMM', 'da_DK').format(parsedDate))}-${parsedDate.day}",
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
    });
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDataFromFirebase(String id) async {
    return await _firestore.collection('admins').doc(id).get();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getDriverFromFirebase(String id) async {
    return await _firestore.collection('drivers').doc(id).get();
  }

  setNotificationID(String? notificationID, String driverID) async {
    await _firestore.collection('drivers').doc(driverID).update({
      'notification': notificationID
    });
  }
  
  completeTask(CompleteTask task) async {
    await _firestore.collection('requests').doc(task.taskId).collection('completed').doc('details').set({
      'given': task.given,
      'startTime': task.startTime,
      'endTime': task.endTime,
      'hourlyRate': task.hourlyRate,
      'numberOfHours': task.numberOfHours,
      'paymentType': task.paymentType,
      'heavyLifting': task.heavyLifting,
      'garbage': task.garbage,
      'storage': task.storage,
      'total': task.total,
      'image1': task.image1,
      'image2': task.image2,
      'image3': task.image3,
      'image4': task.image4,
      'image5': task.image5,
      'image6': task.image6,
      'image7': task.image7,
      'image8': task.image8,
      'driverName': task.driverName,
      'customerName': task.customerName,
      'customerSign': task.customerSign
    });

    await _firestore.collection('requests').doc(task.taskId).update({
      'isCompleted': true,
    });
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getCompletedTask(String id) async {
    return await _firestore.collection('requests').doc(id).collection('completed').doc('details').get();
  }

}
