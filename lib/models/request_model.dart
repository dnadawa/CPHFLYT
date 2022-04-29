import 'package:cphflyt/controllers/filter_controller.dart';
import 'package:cphflyt/models/address_model.dart';

class RequestModel {

  final String id;
  final String firstName;
  final String lastName;
  final String telePhone;
  final String email;
  final String type;
  final String packageType;
  final String date;
  final AddressModel fromAddress;
  final AddressModel toAddress;
  final String flexible;
  final bool isPacking;
  final bool isCleaning;
  final bool isHeavy;
  final String heavyCount;
  final bool isBreakable;
  final String breakCount;
  final String others;
  final Filter status;
  final String driver;

  RequestModel({
        required this.id,
        required this.firstName,
        required this.lastName,
        required this.telePhone,
        required this.email,
        required this.type,
        required this.packageType,
        required this.date,
        required this.fromAddress,
        required this.toAddress,
        required this.flexible,
        required this.isPacking,
        required this.isCleaning,
        required this.isHeavy,
        required this.heavyCount,
        required this.isBreakable,
        required this.breakCount,
        required this.others,
        required this.status,
        this.driver = ""
      });



}