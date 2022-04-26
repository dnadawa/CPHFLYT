import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cphflyt/services/database_service.dart';

class DriverController {

  Future<QuerySnapshot<Map<String, dynamic>>> getRequests(String driverID) {
    return DatabaseService().getRequestsAsDriver(driverID);
  }

  _sortRequests(){

  }

}