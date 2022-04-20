import 'package:cphflyt/models/user_model.dart';

class Driver extends User{

  final String name;

  Driver({required String uid, required String? email,required this.name}) : super(uid, email);

}