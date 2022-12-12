import 'dart:convert';

import 'package:employee_management/Model/CompanyModel.dart';

ClientModel employeeModelJson(String str) =>
    ClientModel.fromJson(json.decode(str));

String ClientModelToJson(ClientModel data) => json.encode(data.toJson());

class ClientModel {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  int? tel;
  CompanyModel? company;

  ClientModel({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.tel,
    this.company,
  });

  factory ClientModel.fromJson(Map<String, dynamic> json) => ClientModel(
        firstName: json["firstname"],
        lastName: json["lastname"],
        id: json["id"],
        email: json["email"],
        tel: json["tel"],
        company: json["company"],
      );

  Map<String, dynamic> toJson() => {
        "firstname": firstName,
        "lastname": lastName,
        'id': id,
        "email": email,
        "tel": tel,
        "company": company,
      };

  String? get firstname => firstName;
  String? get lastname => lastName;
  String? get Email => email;
  int? get Tel => tel;
  CompanyModel? get cmp => company;
  String? getcompanyName() {
    return this.company!.companyname;
  }
}
