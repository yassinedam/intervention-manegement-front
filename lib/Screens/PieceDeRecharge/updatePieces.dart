import 'dart:convert';

import 'package:employee_management/Model/MachineModel.dart';
import 'package:employee_management/Model/PieceDeReChargeModel.dart';
import 'package:employee_management/Screens/adminDrawer.dart';
import 'package:employee_management/shared.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class updatePiece extends StatefulWidget {
  PieceDeReChargeModel? piece;

  @override
  State<StatefulWidget> createState() {
    return updatePieceState(piece);
  }

  updatePiece(this.piece);
}

String hostip = gethost();
Future<PieceDeReChargeModel?>? updatePiecess(
    PieceDeReChargeModel piece, BuildContext context) async {
  var Url = "http://" + hostip + ":8080/updatepiece";
  var response = await http.put(Uri.parse(Url),
      headers: <String, String>{"Content-Type": "application/json"},
      body: jsonEncode(piece));
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

class updatePieceState extends State<updatePiece> {
  PieceDeReChargeModel? piece;
  final minimumPadding = 5.0;
  TextEditingController? codeController;
  bool _isEnabled = false;
  TextEditingController? designationController;
  TextEditingController? prixController;
  TextEditingController? qteController;
  TextEditingController? remiseController;
  TextEditingController? tvaController;
  TextEditingController? totaleController;
  Future<List<MachineModel>>? machines;

  updatePieceState(this.piece) {
    codeController = TextEditingController(text: this.piece!.code);
    designationController =
        TextEditingController(text: this.piece!.designation);
    prixController = TextEditingController(text: this.piece!.prix.toString());
    qteController = TextEditingController(text: this.piece!.qte.toString());
    remiseController =
        TextEditingController(text: this.piece!.remise.toString());
    tvaController = TextEditingController(text: this.piece!.tVA.toString());
    totaleController =
        TextEditingController(text: this.piece!.totalHT.toString());
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
                        controller: prixController,
                        validator: (String? value) {
                          if (value != null && value.isEmpty) {
                            return 'please enter The price of the part';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'The price of the part',
                            hintText: 'Enter The price of the part',
                            labelStyle: textStyle,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      )),
                  Padding(
                      padding: EdgeInsets.only(
                          top: minimumPadding, bottom: minimumPadding),
                      child: TextFormField(
                        style: textStyle,
                        controller: qteController,
                        validator: (String? value) {
                          if (value != null && value.isEmpty) {
                            return 'please enter The Quntity in Stock';
                          }
                        },
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
                        controller: remiseController,
                        validator: (String? value) {
                          if (value != null && value.isEmpty) {
                            return 'please enter The sold on the piece';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'The sold on the piece',
                            hintText: 'Enter The sold on the piece',
                            labelStyle: textStyle,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      )),
                  Padding(
                      padding: EdgeInsets.only(
                          top: minimumPadding, bottom: minimumPadding),
                      child: TextFormField(
                        style: textStyle,
                        controller: tvaController,
                        validator: (String? value) {
                          if (value != null && value.isEmpty) {
                            return 'please enter The tva on the piece';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'The tva on the piece',
                            hintText: 'Enter The tva on the piece',
                            labelStyle: textStyle,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      )),
                  Padding(
                      padding: EdgeInsets.only(
                          top: minimumPadding, bottom: minimumPadding),
                      child: TextFormField(
                        style: textStyle,
                        controller: totaleController,
                        validator: (String? value) {
                          if (value != null && value.isEmpty) {
                            return 'please enter The totale of the piece';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'The totale of the piece',
                            hintText: 'Enter The totale of the piece',
                            labelStyle: textStyle,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      )),
                  ElevatedButton(
                      child: Text('Update Details'),
                      onPressed: () async {
                        String code = codeController!.text;
                        String designation = designationController!.text;
                        double prix = double.parse(prixController!.text);
                        int qte = int.parse(qteController!.text);
                        double remise = double.parse(remiseController!.text);
                        double tva = double.parse(tvaController!.text);
                        double totale = double.parse(totaleController!.text);
                        PieceDeReChargeModel? pic = new PieceDeReChargeModel(
                            code: '',
                            designation: '',
                            prix: -1,
                            remise: -1,
                            qte: -1);
                        pic.code = code;
                        pic.designation = designation;
                        pic.prix = prix;
                        pic.qte = qte;
                        pic.remise = remise;
                        pic.tVA = tva;
                        pic.totalHT = totale;
                        PieceDeReChargeModel? pieces =
                            await updatePiecess(pic, context);
                        setState(() {
                          piece = pieces;
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
