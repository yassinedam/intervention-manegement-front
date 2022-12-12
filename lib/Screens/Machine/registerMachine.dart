import 'dart:convert';

import 'package:employee_management/Model/MachineModel.dart';
import 'package:employee_management/shared.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class registerMachine extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return registerMachineState();
  }
}

String hostip = gethost();
Future<MachineModel?> registerMachines(String code, String designation,
    int qteDisp, int qteStock, int qteEnInstance, BuildContext context) async {
  var Url = "http://" + hostip + ":8080/addmachine";
  var response = await http.post(Uri.parse(Url),
      headers: <String, String>{"Content-Type": "application/json"},
      body: jsonEncode(<String, dynamic>{
        "code": code,
        "designation": designation,
        'qteDisp': qteDisp,
        "qteStock": qteStock,
        "qteEnInstance": qteEnInstance,
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

class registerMachineState extends State<registerMachine> {
  final minimumPadding = 5.0;

  TextEditingController codeController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  TextEditingController qteDispController = TextEditingController();
  TextEditingController qteStockController = TextEditingController();
  TextEditingController qteEnInstanceController = TextEditingController();
  MachineModel? machine;

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.subtitle2;
    return Scaffold(
      appBar: AppBar(
        title: Text("Register Machine"),
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
                    controller: codeController,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'please Enter the code the Machine';
                      }
                    },
                    decoration: InputDecoration(
                        labelText: 'Code',
                        hintText: 'Enter the Code',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  )),
              Padding(
                  padding: EdgeInsets.only(
                      top: minimumPadding, bottom: minimumPadding),
                  child: TextFormField(
                    style: textStyle,
                    controller: designationController,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'please Enter the designation the Machine';
                      }
                    },
                    decoration: InputDecoration(
                        labelText: 'Designation',
                        hintText: 'Enter the designation of the Machine',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  )),
              Padding(
                  padding: EdgeInsets.only(
                      top: minimumPadding, bottom: minimumPadding),
                  child: TextFormField(
                    style: textStyle,
                    controller: qteDispController,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'please enter the Disponible Quntity';
                      }
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'the Disponible Quntity',
                        hintText: 'Enter the Disponible Quntity',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  )),
              Padding(
                  padding: EdgeInsets.only(
                      top: minimumPadding, bottom: minimumPadding),
                  child: TextFormField(
                    style: textStyle,
                    controller: qteStockController,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'please enter the quntity en stock';
                      }
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'the quntity en stock',
                        hintText: 'Enter the quntity en stock',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  )),
              Padding(
                  padding: EdgeInsets.only(
                      top: minimumPadding, bottom: minimumPadding),
                  child: TextFormField(
                    style: textStyle,
                    controller: qteEnInstanceController,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'please enter the quntity en instance';
                      }
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'the quntity en instance',
                        hintText: 'Enter the quntity en instance',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  )),
              RaisedButton(
                  child: Text('Submit'),
                  onPressed: () async {
                    String code = codeController.text;
                    String designtion = designationController.text;
                    int qteDisp = int.parse(qteDispController.text);
                    int qteStock = int.parse(qteStockController.text);
                    int qteEnInstance = int.parse(qteEnInstanceController.text);
                    MachineModel? machines = await registerMachines(code,
                        designtion, qteDisp, qteStock, qteEnInstance, context);
                    codeController.text = '';
                    designationController.text = '';
                    qteStockController.text = '';
                    qteDispController.text = '';
                    qteEnInstanceController.text = '';
                    setState(() {
                      machine = machines;
                    });
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
