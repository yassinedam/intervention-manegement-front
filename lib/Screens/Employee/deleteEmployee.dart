import 'dart:convert';

import 'package:employee_management/Model/EmployeeModel.dart';
import 'package:employee_management/Screens/Employee/getEmployees.dart';
import 'package:employee_management/shared.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class deleteEmployee extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return deleteEmployeeState();
  }
}

String hostip = gethost();
Future<EmployeeModel> deleteEmployees(EmployeeModel employee,
    BuildContext context, String firstName, String lastName) async {
  var Url = "http://" + hostip + ":8080/deleteemployee";
  var response = await http.delete(
    Uri.parse(Url),
    headers: <String, String>{
      "Content-Type": "application/json;charset=UTF-8,"
    },
  );
  return EmployeeModel.fromJson(jsonDecode(response.body));
}

class deleteEmployeeState extends State<deleteEmployee> {
  @override
  Widget build(BuildContext context) {
    return getemployees();
  }
}
