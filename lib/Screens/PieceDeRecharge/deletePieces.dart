import 'dart:convert';

import 'package:employee_management/Model/ClientModel.dart';
import 'package:employee_management/Screens/PieceDeRecharge/getPieces.dart';
import 'package:employee_management/shared.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class deletePiece extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return deletePieceState();
  }
}

String hostip = gethost();
Future<ClientModel?> deleteMachines(
    String firstName, String lastName, String Email, int tel) async {
  var Url = "http://" + hostip + ":8080/deletepiece";
  var response = await http.delete(
    Uri.parse(Url),
    headers: <String, String>{
      "Content-Type": "application/json;charset=UTF-8,"
    },
  );
}

class deletePieceState extends State<deletePiece> {
  @override
  Widget build(BuildContext context) {
    return getPieces();
  }
}
