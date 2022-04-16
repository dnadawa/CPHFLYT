import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cphflyt/models/address_model.dart';
import 'package:cphflyt/models/request_model.dart';

class DatabaseService{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  Stream<QuerySnapshot<Map<String, dynamic>>> getRequests() {
    return _firestore.collection('requests').snapshots();
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
      );

      return requestModel;
  }

}
