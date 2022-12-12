import 'dart:convert';

import 'package:employee_management/Model/ClientModel.dart';
import 'package:employee_management/Screens/Client/getClients.dart';
import 'package:employee_management/shared.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class deleteClient extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return deleteClientState();
  }
}

String hostip = gethost();
Future<ClientModel?> deleteclients(
    String firstName, String lastName, String Email, int tel) async {
  var Url = "http://" + hostip + ":8080/deleteclient";
  var response = await http.delete(
    Uri.parse(Url),
    headers: <String, String>{
      "Content-Type": "application/json;charset=UTF-8,"
    },
  );
}

class deleteClientState extends State<deleteClient> {
  @override
  Widget build(BuildContext context) {
    return getClients();
  }
}
