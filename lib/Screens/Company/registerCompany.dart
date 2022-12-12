import 'dart:convert';

import 'package:employee_management/Model/CompanyModel.dart';
import 'package:employee_management/Screens/Client/registerClient.dart';
import 'package:employee_management/shared.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class registerCompany extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return registerCompanyState();
  }
}

String hostip = gethost();
Future<CompanyModel?> registerCompanies(String? mf, String? companyname,
    String? adresse, int? tel, BuildContext context) async {
  var Url = "http://" + hostip + ":8080/addcompany";
  print(mf);
  var response = await http.post(Uri.parse(Url),
      headers: <String, String>{"Content-Type": "application/json"},
      body: jsonEncode(<String, dynamic>{
        "mf": mf,
        'companyName': companyname,
        "adresse": adresse,
        "tel": tel,
      }));

  String responseString = response.body;
  if (response.statusCode == 200) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return MyAlertDialog(title: 'Backend Response', content: response.body);
      },
    );
  }
}

class registerCompanyState extends State<registerCompany> {
  final minimumPadding = 5.0;

  TextEditingController mfController = TextEditingController();
  TextEditingController companynameController = TextEditingController();
  TextEditingController adresseController = TextEditingController();
  TextEditingController telController = TextEditingController();
  CompanyModel? company;

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.subtitle2;
    return Scaffold(
      appBar: AppBar(
        title: Text("Register Employee"),
      ),
      body: Form(
        child: Padding(
          padding: EdgeInsets.all(minimumPadding * 2),
          child: ListView(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(
                      top: minimumPadding, bottom: minimumPadding),
                  child: TextFormField(
                    style: textStyle,
                    controller: mfController,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'please enter the matricule fiscale';
                      }
                    },
                    decoration: InputDecoration(
                        labelText: 'matricule fiscale',
                        hintText: 'Enter The matricule fiscale',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  )),
              Padding(
                  padding: EdgeInsets.only(
                      top: minimumPadding, bottom: minimumPadding),
                  child: TextFormField(
                    style: textStyle,
                    controller: companynameController,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'please enter the Company Name';
                      }
                    },
                    decoration: InputDecoration(
                        labelText: 'the Company Name',
                        hintText: 'Enter the Company Name',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  )),
              Padding(
                  padding: EdgeInsets.only(
                      top: minimumPadding, bottom: minimumPadding),
                  child: TextFormField(
                    style: textStyle,
                    controller: adresseController,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'please enter The Adresse of the company';
                      }
                    },
                    decoration: InputDecoration(
                        labelText: 'The Adresse of the company',
                        hintText: 'Enter The Adresse of the company',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  )),
              Padding(
                  padding: EdgeInsets.only(
                      top: minimumPadding, bottom: minimumPadding),
                  child: TextFormField(
                    style: textStyle,
                    controller: telController,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'please the Phone Number';
                      }
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'the Phone Number',
                        hintText: 'Enter the Phone Number',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  )),
              RaisedButton(
                  child: Text('Submit'),
                  onPressed: () async {
                    String? mf = mfController.text;
                    String? companyName = companynameController.text;
                    String? adresse = adresseController.text;
                    int? tel = int.parse(telController.text);
                    CompanyModel? companies = await registerCompanies(
                        mf, companyName, adresse, tel, context);
                    mfController.text = '';
                    companynameController.text = '';
                    adresseController.text = '';
                    telController.text = '';
                    setState(() {
                      company = companies;
                    });
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => registerClient()));
                  })
            ],
          ),
        ),
      ),
    );
  }
}

class MyAlertDialog extends StatelessWidget {
  final String? title;
  final String? content;
  final List<Widget> actions;

  MyAlertDialog({
    this.title,
    this.content,
    this.actions = const [],
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        this.title!,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      actions: this.actions,
      content: Text(
        this.content!,
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}
