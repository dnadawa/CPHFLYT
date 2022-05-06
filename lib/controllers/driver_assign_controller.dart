import 'package:cphflyt/controllers/notification_controller.dart';
import 'package:cphflyt/models/driver_model.dart';
import 'package:cphflyt/models/request_model.dart';
import 'package:cphflyt/services/database_service.dart';
import 'package:cphflyt/widgets/custom_text.dart';
import 'package:cphflyt/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:cphflyt/controllers/bottom_nav_controller.dart';

class DriverAssignController extends ChangeNotifier{
  String? _selectedDriver;

  set selectedDriver(String? index){
    _selectedDriver = index;
    notifyListeners();
  }

  String? get selectedDriver{
    return _selectedDriver;
  }

  Driver createDriverFromDocument(var doc){
    return Driver(uid: doc.id, email: doc['email'], name: doc['name']);
  }

  void assignDriver(String? uid,String requestID, BuildContext context) async {
      ToastBar(text: "Please wait", color: Colors.orange).show();
      try{
        await DatabaseService().assignDriver(uid, requestID);
        var doc = await DatabaseService().getDriverFromFirebase(uid!);
        if (doc.data()!.containsKey('notification') && doc.data()!['notification'] != null){
          await NotificationController().sendNotification(doc.data()!['notification']);
        }

        ToastBar(text: "Driver is successfully added to the task.", color: Colors.green).show();
        Navigator.popUntil(context, (route) => route.isFirst);
      }
      catch(e){
        ToastBar(text: e.toString(), color: Colors.red).show();
      }
  }

  void trashRequest(String requestID, BuildContext context) async {
    ToastBar(text: "Please wait", color: Colors.orange).show();
    try{
      await DatabaseService().trashRequest(requestID);
      ToastBar(text: "Request Declined!", color: Colors.green).show();
      Navigator.popUntil(context, (route) => route.isFirst);
    }
    catch(e){
      ToastBar(text: e.toString(), color: Colors.red).show();
    }
  }

  void emptyTrash(Nav type, BuildContext context) {
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        content: CustomText(text: "Are you sure you want to clear the trash?"),
        actions: [
          TextButton(onPressed: () async {
            ToastBar(text: "Please wait", color: Colors.orange).show();
            try{
              await DatabaseService().emptyTrash(type);
              ToastBar(text: "Trash Cleared!", color: Colors.green).show();
              Navigator.pop(context);
            }
            catch(e){
              ToastBar(text: e.toString(), color: Colors.red).show();
            }
          }, child: CustomText(text: "Yes")),
          TextButton(onPressed: ()=>Navigator.pop(context), child: CustomText(text: "No")),
        ],
      );
    });
  }

  Future<void> addRequest(RequestModel request, BuildContext context) async {
    ToastBar(text: "Please wait", color: Colors.orange).show();
    try{
      await DatabaseService().addRequest(request);
      ToastBar(text: "New Task Added!", color: Colors.green).show();
      Navigator.popUntil(context, (route) => route.isFirst);
    }
    catch (e){
      ToastBar(text: e.toString(), color: Colors.red).show();
    }
  }

  Future<void> editRequest(RequestModel request, BuildContext context) async {
    ToastBar(text: "Please wait", color: Colors.orange).show();
    try{
      await DatabaseService().editRequest(request);
      ToastBar(text: "Task Edited!", color: Colors.green).show();
    }
    catch (e){
      ToastBar(text: e.toString(), color: Colors.red).show();
    }
  }

}