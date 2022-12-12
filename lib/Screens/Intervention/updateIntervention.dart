import 'dart:convert';

import 'package:employee_management/Model/EmployeeModel.dart';
import 'package:employee_management/Model/InterventionModel.dart';
import 'package:employee_management/Screens/Client/deleteClient.dart';
import 'package:employee_management/Screens/adminDrawer.dart';
import 'package:employee_management/shared.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class updateIntervention extends StatefulWidget {
  InterventionModel? intervention;

  @override
  State<StatefulWidget> createState() {
    return updateInterventionState(intervention);
  }

  updateIntervention(this.intervention);
}

String hostip = gethost();
Future<InterventionModel?>? updateInterventions(
    InterventionModel? intervention, BuildContext context) async {
  var Url = "http://" + hostip + ":8080/updateintervention";
  var response = await http.put(Uri.parse(Url),
      headers: <String, String>{"Content-Type": "application/json"},
      body: jsonEncode(intervention));
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

class updateInterventionState extends State<updateIntervention> {
  InterventionModel? intervention;
  final minimumPadding = 5.0;
  TextEditingController? InterventionNumber;
  bool _isEnabled = false;
  TextEditingController? dateController;
  TextEditingController? dureeController;
  TextEditingController? numeroInterventionController;
  TextEditingController? nbDeviceController;
  TextEditingController? natureInterventionController;
  TextEditingController? descriptionInterventionController;
  TextEditingController? observationController;
  Future<List<EmployeeModel>>? employees;

  updateInterventionState(this.intervention) {
    InterventionNumber =
        TextEditingController(text: this.intervention!.id.toString());
    dateController = TextEditingController(text: this.intervention!.date);
    dureeController =
        TextEditingController(text: this.intervention!.duree.toString());
    numeroInterventionController = TextEditingController(
        text: this.intervention!.numeroIntervention.toString());
    nbDeviceController =
        TextEditingController(text: this.intervention!.nbDevice.toString());
    natureInterventionController =
        TextEditingController(text: this.intervention!.natureIntervention);
    descriptionInterventionController =
        TextEditingController(text: this.intervention!.descriptionIntervention);
    observationController =
        TextEditingController(text: this.intervention!.observation);
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
                        controller: InterventionNumber,
                        enabled: _isEnabled,
                        validator: (String? value) {
                          if (value != null && value.isEmpty) {
                            return 'please enter your ID';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'Intervention ID',
                            hintText: 'Enter Intervention ID',
                            labelStyle: textStyle,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      )),
                  Padding(
                      padding: EdgeInsets.only(
                          top: minimumPadding, bottom: minimumPadding),
                      child: TextFormField(
                        style: textStyle,
                        controller: dateController,
                        validator: (String? value) {
                          if (value != null && value.isEmpty) {
                            return 'please the date ';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'date',
                            hintText: 'Enter the date',
                            labelStyle: textStyle,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      )),
                  Padding(
                      padding: EdgeInsets.only(
                          top: minimumPadding, bottom: minimumPadding),
                      child: TextFormField(
                        style: textStyle,
                        controller: dureeController,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'please the necessary amount of time';
                          }
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: 'please the necessary amount of time',
                            hintText:
                                'Enter please the necessary amount of time',
                            labelStyle: textStyle,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      )),
                  Padding(
                      padding: EdgeInsets.only(
                          top: minimumPadding, bottom: minimumPadding),
                      child: TextFormField(
                        style: textStyle,
                        controller: numeroInterventionController,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'please enter the intervention Number';
                          }
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: 'the intervention Number',
                            hintText: 'Enter the intervention Number',
                            labelStyle: textStyle,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      )),
                  Padding(
                      padding: EdgeInsets.only(
                          top: minimumPadding, bottom: minimumPadding),
                      child: TextFormField(
                        style: textStyle,
                        controller: nbDeviceController,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'please enter the number of devices';
                          }
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: 'the number of devices',
                            hintText: 'Enter the number of devices',
                            labelStyle: textStyle,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      )),
                  Padding(
                      padding: EdgeInsets.only(
                          top: minimumPadding, bottom: minimumPadding),
                      child: TextFormField(
                        style: textStyle,
                        controller: natureInterventionController,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'please enter the nature of the intervention';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'the nature of the intervention',
                            hintText: 'Enter the nature of the intervention',
                            labelStyle: textStyle,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      )),
                  Padding(
                      padding: EdgeInsets.only(
                          top: minimumPadding, bottom: minimumPadding),
                      child: TextFormField(
                        style: textStyle,
                        controller: descriptionInterventionController,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'please enter the description of the intervention';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'the description of the intervention',
                            hintText:
                                'Enter the description of the intervention',
                            labelStyle: textStyle,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      )),
                  Padding(
                      padding: EdgeInsets.only(
                          top: minimumPadding, bottom: minimumPadding),
                      child: TextFormField(
                        style: textStyle,
                        controller: observationController,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'please enter the Observation';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'the Observation',
                            hintText: 'Enter the Observation',
                            labelStyle: textStyle,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      )),
                  ElevatedButton(
                      child: Text('Update Details'),
                      onPressed: () async {
                        String? date = dateController!.text;
                        int? duree = int.parse(dureeController!.text);
                        int? nbdevice = int.parse(nbDeviceController!.text);
                        int? numintervention =
                            int.parse(numeroInterventionController!.text);
                        String? description =
                            descriptionInterventionController!.text;
                        String? nature = natureInterventionController!.text;
                        String? obs = observationController!.text;
                        InterventionModel? inter = new InterventionModel(
                          id: -1,
                        );
                        inter.id = int.parse(InterventionNumber!.text);
                        inter.date = date;
                        inter.duree = duree;
                        inter.nbDevice = nbdevice;
                        inter.numeroIntervention = numintervention;
                        inter.descriptionIntervention = description;
                        inter.natureIntervention = nature;
                        inter.observation = obs;
                        InterventionModel? interventions =
                            await updateInterventions(inter, context);
                        setState(() {
                          intervention = interventions;
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
