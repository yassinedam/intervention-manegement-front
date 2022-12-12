import 'dart:convert';

import 'package:employee_management/Model/ClientModel.dart';
import 'package:employee_management/Screens/Machine/getMachines.dart';
import 'package:employee_management/shared.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class deleteMachine extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return deleteMachineState();
  }
}

String hostip = gethost();
Future<ClientModel?> deleteMachines(
    String firstName, String lastName, String Email, int tel) async {
  var Url = "http://" + hostip + ":8080/deletemachine";
  var response = await http.delete(
    Uri.parse(Url),
    headers: <String, String>{
      "Content-Type": "application/json;charset=UTF-8,"
    },
  );
}

class deleteMachineState extends State<deleteMachine> {
  @override
  Widget build(BuildContext context) {
    return getMachines();
  }
}
