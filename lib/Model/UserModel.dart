import 'dart:convert';

import 'package:employee_management/Model/CompanyModel.dart';
import 'package:employee_management/Model/EmployeeModel.dart';

UserModel employeeModelJson(String str) => UserModel.fromJson(json.decode(str));

String ClientModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  int? identity;
  String? userName;
  int? rank;
  String? password;
  int? tel;
  EmployeeModel? employee;

  UserModel({
    this.identity,
    this.userName,
    this.rank,
    this.password,
    this.tel,
    this.employee,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        identity: json["identity"],
        userName: json["userName"],
        rank: json["rank"],
        password: json["password"],
        tel: json["tel"],
        employee: json["employee"],
      );

  Map<String, dynamic> toJson() => {
        "identity": identity,
        "userName": userName,
        "rank": rank,
        "password": password,
        "tel": tel,
        "employee": employee,
      };

  int? get id => identity;
  String? get username => userName;
  String? get passwd => password;
  int? get phone => tel;
}
