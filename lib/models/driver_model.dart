import 'package:cphflyt/models/user_model.dart';

class Driver extends User {
  final String name;
  final String phone;

  Driver({required String uid, required String? email, required this.name, required this.phone}) : super(uid, email);
}
