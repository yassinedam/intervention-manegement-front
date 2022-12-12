import 'dart:convert';

import 'package:employee_management/Model/MachineModel.dart';
import 'package:employee_management/Screens/Client/deleteClient.dart';
import 'package:employee_management/Screens/adminDrawer.dart';
import 'package:employee_management/shared.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class updateMachine extends StatefulWidget {
  MachineModel? machine;

  @override
  State<StatefulWidget> createState() {
    return updateMachineState(machine);
  }

  updateMachine(this.machine);
}

String hostip = gethost();
Future<MachineModel?> updateMachines(
    MachineModel machine, BuildContext context) async {
  var Url = "http://" + hostip + ":8080/updatemachine";
  var response = await http.put(Uri.parse(Url),
      headers: <String, String>{"Content-Type": "application/json"},
      body: jsonEncode(machine));
  String responseString = response.body;
  if (response.statusCode == 200) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext dialogContext) {
          return MyAlertDialog(
              title: 'Backend Response', content: response.body);
        });
  }
}

class updateMachineState extends State<updateMachine> {
  MachineModel? machine;
  final minimumPadding = 5.0;
  TextEditingController? codeController;
  bool _isEnabled = false;
  TextEditingController? designationController;
  TextEditingController? qteDispController;
  TextEditingController? qteEnStockController;
  TextEditingController? qteEnInstanceController;
  Future<List<MachineModel>>? machines;

  updateMachineState(this.machine) {
    codeController = TextEditingController(text: this.machine!.code);
    designationController =
        TextEditingController(text: this.machine!.designation);
    qteDispController =
        TextEditingController(text: this.machine!.qteDisp.toString());
    qteEnStockController =
        TextEditingController(text: this.machine!.qteStock.toString());
    qteEnInstanceController =
        TextEditingController(text: this.machine!.qteEnInstance.toString());
  }

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.subtitle2;
    return Scaffold(
        appBar: AppBar(
          title: Text('Update Employee'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => adminDrawer()));
            },
          ),
        ),
        body: Container(
            child: Padding(
                padding: EdgeInsets.all(minimumPadding * 2),
                child: ListView(children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(
                          top: minimumPadding, bottom: minimumPadding),
                      child: TextFormField(
                        style: textStyle,
                        controller: codeController,
                        enabled: _isEnabled,
                        validator: (String? value) {
                          if (value != null && value.isEmpty) {
                            return 'please enter the machine code';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'the Code of the Machine',
                            hintText: 'Enter the Code of the Machine',
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
                          if (value != null && value.isEmpty) {
                            return 'please enter the designation of the machine';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'The designation of the machine',
                            hintText: 'Enter The designation of the machine',
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
                          if (value != null && value.isEmpty) {
                            return 'please enter The disponible Quntity disponible';
                          }
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: 'The disponible Quntity disponible',
                            hintText: 'Enter The disponible Quntity disponible',
                            labelStyle: textStyle,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      )),
                  Padding(
                      padding: EdgeInsets.only(
                          top: minimumPadding, bottom: minimumPadding),
                      child: TextFormField(
                        style: textStyle,
                        controller: qteEnStockController,
                        validator: (String? value) {
                          if (value != null && value.isEmpty) {
                            return 'please enter The Quntity in Stock';
                          }
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: 'The Quntity in Stock',
                            hintText: 'Enter The Quntity in Stock',
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
                          if (value != null && value.isEmpty) {
                            return 'please enter The Quntity in Instance';
                          }
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: 'The Quntity in Instance',
                            hintText: 'Enter The Quntity in Instance',
                            labelStyle: textStyle,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      )),
                  ElevatedButton(
                      child: Text('Update Details'),
                      onPressed: () async {
                        String code = codeController!.text;
                        String designation = designationController!.text;
                        int qteDisp = int.parse(qteDispController!.text);
                        int qteStock = int.parse(qteEnStockController!.text);
                        int qteEnInstance =
                            int.parse(qteEnInstanceController!.text);
                        MachineModel? mac = new MachineModel(
                            code: '',
                            designation: '',
                            qteDisp: -1,
                            qteEnInstance: -1,
                            qteStock: -1);
                        mac.code = code;
                        mac.designation = designation;
                        mac.qteDisp = qteDisp;
                        mac.qteStock = qteStock;
                        mac.qteEnInstance = qteEnInstance;
                        MachineModel? machines =
                            await updateMachines(mac, context);
                        setState(() {
                          machine = machines;
                        });
                      })
                ]))));
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
