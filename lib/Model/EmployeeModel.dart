import 'dart:convert';

EmployeeModel employeeModelJson(String str) =>
    EmployeeModel.fromJson(json.decode(str));

String employeeModelToJson(EmployeeModel data) => json.encode(data.toJson());

class EmployeeModel {
  int? id;
  String? firstName;
  String? lastName;
  String? Email;
  int? tel;
  List? inventions;

  EmployeeModel(
      {this.id,
      this.firstName,
      this.lastName,
      this.Email,
      this.tel,
      this.inventions});

  factory EmployeeModel.fromJson(Map<String, dynamic> json) => EmployeeModel(
        firstName: json["firstName"],
        lastName: json["lastName"],
        id: json["id"],
        Email: json["Email"],
        tel: json["tel"],
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        'id': id,
        "Email": Email,
        "tel": tel,
      };

  String? get firstname => firstName;
  String? get lastname => lastName;
  String? get email => Email;
  int? get Tel => tel;
}
