import 'dart:convert';

import 'package:employee_management/Model/PieceDeReChargeModel.dart';
import 'package:employee_management/shared.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class registerPieceDeRecharge extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return registerPieceDeRechargeState();
  }
}

String hostip = gethost();
Future<PieceDeReChargeModel?> registerPieces(
    String code,
    String designation,
    int qte,
    double prix,
    double tVA,
    double remise,
    double totalHT,
    BuildContext context) async {
  var Url = "http://" + hostip + ":8080/addpiece";
  var response = await http.post(Uri.parse(Url),
      headers: <String, String>{"Content-Type": "application/json"},
      body: jsonEncode(<String, dynamic>{
        "code": code,
        "designation": designation,
        'qte': qte,
        "prix": prix,
        "tVA": tVA,
        "remise": remise,
        "totalHT": totalHT,
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

class registerPieceDeRechargeState extends State<registerPieceDeRecharge> {
  final minimumPadding = 5.0;

  TextEditingController codeController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  TextEditingController qteController = TextEditingController();
  TextEditingController prixController = TextEditingController();
  TextEditingController tVAController = TextEditingController();
  TextEditingController remiseController = TextEditingController();
  TextEditingController totalController = TextEditingController();
  PieceDeReChargeModel? piece;

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.subtitle2;
    return Scaffold(
      appBar: AppBar(
        title: Text("Register Recharge Piece"),
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
                        return 'please Enter the code the Piece';
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
                        return 'please Enter the designation the Piece';
                      }
                    },
                    decoration: InputDecoration(
                        labelText: 'Designation',
                        hintText: 'Enter the designation of the Piece',
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
                      if (value!.isEmpty) {
                        return 'please enter the  Quntity';
                      }
                    },
                    decoration: InputDecoration(
                        labelText: 'the Quntity',
                        hintText: 'Enter the Quntity',
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
                      if (value!.isEmpty) {
                        return 'please enter the Price';
                      }
                    },
                    decoration: InputDecoration(
                        labelText: 'the Price',
                        hintText: 'Enter the Price',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  )),
              Padding(
                  padding: EdgeInsets.only(
                      top: minimumPadding, bottom: minimumPadding),
                  child: TextFormField(
                    style: textStyle,
                    controller: tVAController,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'please enter the TVA';
                      }
                    },
                    decoration: InputDecoration(
                        labelText: 'the TVA',
                        hintText: 'Enter the TVA',
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
                      if (value!.isEmpty) {
                        return 'please enter the Sold';
                      }
                    },
                    decoration: InputDecoration(
                        labelText: 'the Sold',
                        hintText: 'Enter the Sold',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  )),
              Padding(
                  padding: EdgeInsets.only(
                      top: minimumPadding, bottom: minimumPadding),
                  child: TextFormField(
                    style: textStyle,
                    controller: totalController,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'please enter the total';
                      }
                    },
                    decoration: InputDecoration(
                        labelText: 'the total',
                        hintText: 'Enter the total',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  )),
              RaisedButton(
                  child: Text('Submit'),
                  onPressed: () async {
                    String code = codeController.text;
                    String designtion = designationController.text;
                    int qte = int.parse(qteController.text);
                    double prix = double.parse(prixController.text);
                    double tva = double.parse(tVAController.text);
                    double remise = double.parse(remiseController.text);
                    double total = double.parse(totalController.text);
                    PieceDeReChargeModel? pieces = await registerPieces(code,
                        designtion, qte, prix, tva, remise, total, context);
                    codeController.text = '';
                    designationController.text = '';
                    qteController.text = '';
                    prixController.text = '';
                    tVAController.text = '';
                    remiseController.text = '';
                    totalController.text = '';
                    setState(() {
                      piece = pieces;
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
