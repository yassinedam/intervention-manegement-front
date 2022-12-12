import 'dart:convert';

import 'package:employee_management/Model/PieceDeReChargeModel.dart';
import 'package:employee_management/Screens/PieceDeRecharge/deletePieces.dart';
import 'package:employee_management/Screens/PieceDeRecharge/registerPieceDeRecharge.dart';
import 'package:employee_management/Screens/adminDrawer.dart';
import 'package:employee_management/Screens/PieceDeRecharge/updatePieces.dart';
import 'package:employee_management/shared.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class getPieces extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return getAllPiecesState();
  }
}

String hostip = gethost();

class getAllPiecesState extends State<getPieces> {
  var Machiness = List<PieceDeReChargeModel?>.generate(200, (index) => null);
  Future<List<PieceDeReChargeModel?>?> getAllPieces() async {
    String url = 'http://' + hostip + ':8080/getallpieces';
    var data = await http.get(Uri.parse(url));
    var jsonData = json.decode(data.body);
    print(jsonData);
    List<PieceDeReChargeModel?> pieces = [];
    for (var e in jsonData) {
      PieceDeReChargeModel? piece = new PieceDeReChargeModel();
      piece.code = e["code"];
      piece.designation = e["designation"];
      piece.prix = e["prix"];
      piece.qte = e["qte"];
      piece.remise = e["remise"];
      piece.tVA = e["tVA"];
      pieces.add(piece);
    }
    print(pieces.toList().toString());
    return pieces;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("All Pieces Details"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => adminDrawer()));
          },
        ),
      ),
      body: Container(
        child: FutureBuilder<List<PieceDeReChargeModel?>?>(
          future: getAllPieces(),
          builder: (BuildContext context,
              AsyncSnapshot<List<PieceDeReChargeModel?>?> snapshot) {
            if (snapshot.data == null) {
              return Container(child: Center(child: Icon(Icons.error)));
            }
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text('designation'),
                    subtitle: Text('${snapshot.data![index]!.designation}'),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DetailPage(snapshot.data![index])));
                    },
                  );
                });
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => registerPieceDeRecharge()));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  PieceDeReChargeModel? piece;

  DetailPage(this.piece);
  deletePiece1(PieceDeReChargeModel? piece) async {
    final url = Uri.parse('http://' + hostip + ':8080/deletepiece');
    final request = http.Request("DELETE", url);
    request.headers
        .addAll(<String, String>{"Content-type": "application/json"});
    request.body = jsonEncode(piece);
    final response = await request.send();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(piece!.designation.toString()),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.edit,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => updatePiece(piece)));
              })
        ],
      ),
      body: Container(
        child: Text('Code :' +
            ' \n' +
            piece!.code.toString() +
            ' \n' +
            'Designation :' +
            ' \n' +
            piece!.designation.toString() +
            ' \n' +
            'Prix :' +
            ' \n' +
            piece!.prix.toString() +
            ' \n' +
            'Quntitée en Stock :' +
            ' \n' +
            piece!.qte.toString() +
            ' \n' +
            'tva :' +
            piece!.tVA.toString()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          deletePiece1(this.piece);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => deletePiece()));
        },
        child: Icon(Icons.delete),
        backgroundColor: Colors.pink,
      ),
    );
  }
}
