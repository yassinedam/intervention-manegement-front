import 'dart:convert';

import 'package:employee_management/Model/UserModel.dart';
import 'package:employee_management/Screens/PieceDeRecharge/getPieces.dart';
import 'package:employee_management/Screens/User/getUsers.dart';
import 'package:employee_management/shared.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class deleteUser extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return deleteUserState();
  }
}

String hostip = gethost();
Future<UserModel?> deleteMachines() async {
  var Url = "http://" + hostip + ":8080/deleteuser";
  var response = await http.delete(
    Uri.parse(Url),
    headers: <String, String>{
      "Content-Type": "application/json;charset=UTF-8,"
    },
  );
}

class deleteUserState extends State<deleteUser> {
  @override
  Widget build(BuildContext context) {
    return getUsers();
  }
}
