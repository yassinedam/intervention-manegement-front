import 'dart:convert';

import 'package:employee_management/Model/ClientModel.dart';
import 'package:employee_management/Screens/Client/getClients.dart';
import 'package:employee_management/Screens/Company/getCompanies.dart';
import 'package:employee_management/shared.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class deleteCompany extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return deleteCompanyState();
  }
}

String hostip = gethost();
Future<ClientModel?> deletecompanies(
    String firstName, String lastName, String Email, int tel) async {
  var Url = "http://" + hostip + ":8080/deletecompany";
  var response = await http.delete(
    Uri.parse(Url),
    headers: <String, String>{
      "Content-Type": "application/json;charset=UTF-8,"
    },
  );
}

class deleteCompanyState extends State<deleteCompany> {
  @override
  Widget build(BuildContext context) {
    return getCompanies();
  }
}
