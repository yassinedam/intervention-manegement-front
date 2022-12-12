import 'dart:convert';

import 'package:employee_management/Model/ClientModel.dart';
import 'package:employee_management/Screens/Intervention/getIntervention.dart';
import 'package:employee_management/shared.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class deleteIntervention extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return deleteInterventionState();
  }
}

String hostip = gethost();
Future<ClientModel?> deleteintervention(
    String firstName, String lastName, String Email, int tel) async {
  var Url = "http://" + hostip + ":8080/deleteintervention";
  var response = await http.delete(
    Uri.parse(Url),
    headers: <String, String>{
      "Content-Type": "application/json;charset=UTF-8,"
    },
  );
}

class deleteInterventionState extends State<deleteIntervention> {
  @override
  Widget build(BuildContext context) {
    return getInterventions();
  }
}
