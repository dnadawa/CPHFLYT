import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cphflyt/bottom_nav_controller.dart';
import 'package:cphflyt/models/address_model.dart';
import 'package:cphflyt/models/request_model.dart';
import 'package:flutter/cupertino.dart';

enum Filter {Pending, Approved, Trash}

class DatabaseService extends ChangeNotifier{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void updateData(){
    notifyListeners();
  }

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
          date: "${doc['dateYear']}-${doc['dateMonth']}-${doc['dateDay']}",
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

}
