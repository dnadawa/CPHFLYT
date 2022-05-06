import 'package:onesignal_flutter/onesignal_flutter.dart';

class NotificationController{

  getUserID() async {
    final status = await OneSignal.shared.getDeviceState();
    return status?.userId;
  }

  sendNotification(String playerId) async {
    try {
      await OneSignal.shared.postNotification(OSCreateNotification(
        playerIds: [playerId],
        content: "You have received a new job! Please check the app.",
        heading: "You have a new job!",
      ));
    }catch (e){
      print(e.toString());
    }
  }

}