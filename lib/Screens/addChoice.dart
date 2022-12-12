import 'dart:convert';

import 'package:employee_management/Model/PieceDeReChargeModel.dart';
import 'package:employee_management/Screens/Client/registerClient.dart';
import 'package:employee_management/Screens/Company/registerCompany.dart';
import 'package:employee_management/Screens/Intervention/registerIntervention.dart';
import 'package:employee_management/shared.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class addInterventionChoice extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return addInterventionChoiceState();
  }
}

String hostip = gethost();

class addInterventionChoiceState extends State<addInterventionChoice> {
  final minimumPadding = 5.0;
  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.subtitle2;
    return Scaffold(
      appBar: AppBar(
        title: Text("choisir le cas d'intervention à ajouter"),
      ),
      body: Form(
        child: Padding(
          padding: EdgeInsets.all(minimumPadding * 2),
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    top: minimumPadding, bottom: minimumPadding),
                child: RaisedButton(
                    child: Text('Nouveau societé'),
                    onPressed: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => registerCompany()));
                    }),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: minimumPadding, bottom: minimumPadding),
                child: RaisedButton(
                    child: Text('Nouveau client et la socitée déja existe '),
                    onPressed: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => registerClient()));
                    }),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: minimumPadding, bottom: minimumPadding),
                child: RaisedButton(
                    child:
                        Text('Nouveau intervention pour un ancient client  '),
                    onPressed: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => registerIntervention()));
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
