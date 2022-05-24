import 'package:cphflyt/controllers/bottom_nav_controller.dart';
import 'package:cphflyt/models/user_model.dart';

class Employee extends User {
  final String name;
  final Nav page;
  final String phone;

  Employee(
      {required String uid,
      required String? email,
      required this.name,
      required this.phone,
      required this.page})
      : super(uid, email);
}
