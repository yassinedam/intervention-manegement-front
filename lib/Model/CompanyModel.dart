import 'dart:convert';

import 'package:employee_management/Model/ClientModel.dart';

CompanyModel employeeModelJson(String str) =>
    CompanyModel.fromJson(json.decode(str));

String CompanyModelToJson(CompanyModel data) => json.encode(data.toJson());

class CompanyModel {
  String? mf;
  String? companyname;
  int? tel;
  String? adresse;
  List<ClientModel?>? clients;

  CompanyModel(
      {this.mf, this.companyname, this.adresse, this.tel, this.clients});

  factory CompanyModel.fromJson(Map<String, dynamic> json) => CompanyModel(
        mf: json["mf"],
        companyname: json["companyName"],
        tel: json["tel"],
        adresse: json["adresse"],
      );

  Map<String, dynamic> toJson() => {
        "mf": mf,
        "adresse": adresse,
        'companyName': companyname,
        "tel": tel,
      };
  String? get mF => mf;
  String? get companyName => companyname;
  String? get adr => adresse;
  int? get Tel => tel;
}
