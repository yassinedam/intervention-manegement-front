import 'dart:convert';

import 'package:employee_management/Model/InterventionModel.dart';
import 'package:employee_management/Model/ClientModel.dart';
import 'package:employee_management/Model/MachineModel.dart';
import 'package:employee_management/Model/PieceDeReChargeModel.dart';
import 'package:employee_management/Model/EmployeeModel.dart';
import 'package:employee_management/Screens/Intervention/deleteIntervention.dart';
import 'package:employee_management/Screens/adminDrawer.dart';
import 'package:employee_management/Screens/Intervention/updateIntervention.dart';
import 'package:employee_management/shared.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class getInterventionsForIntervenants extends StatefulWidget {
  int? idtentifiction;
  @override
  State<StatefulWidget> createState() {
    return getAllInterventionsForIntervenantState(idtentifiction);
  }

  getInterventionsForIntervenants(this.idtentifiction);
}

String hostip = gethost();
Future<ClientModel?>? getClientForInterventon(
    ClientModel? client, int? id) async {
  String url = 'http://' + hostip + ':8080/getClientByInterventionId/$id';
  var data = await http.get(Uri.parse(url));
  var jsonData = json.decode(data.body);
  print(jsonData);
  client = ClientModel.fromJson(jsonData);
  return client;
}

Future<List<MachineModel?>?>? getAllMachinesinIntervention(
    List<MachineModel?>? machines, int? id) async {
  String url = 'http://' + hostip + ':8080/getallmachinesinIntervention/$id';
  var data = await http.get(Uri.parse(url));
  var jsonData = json.decode(data.body);
  print(jsonData);
  for (var e in jsonData) {
    MachineModel machine = new MachineModel();
    machine.code = e["code"];
    machine.designation = e["designation"];
    machine.qteDisp = e["qteDisp"];
    machine.qteEnInstance = e["qteEnInstance"];
    machine.qteStock = e["qteStock"];
    machines!.add(machine);
  }
  return machines;
}

Future<List<PieceDeReChargeModel?>?>? getallPiecesInIntervention(
    List<PieceDeReChargeModel?>? pieces, int? id) async {
  String url = 'http://' + hostip + ':8080/getallPiecesInIntervention/$id';
  var data = await http.get(Uri.parse(url));
  var jsonData = json.decode(data.body);
  print(jsonData);
  for (var e in jsonData) {
    PieceDeReChargeModel part = new PieceDeReChargeModel();
    part.code = e["code"];
    part.designation = e["designation"];
    part.qte = e["qte"];
    part.remise = e["remise"];
    part.tVA = e["tVA"];
    part.totalHT = e["totalHT"];
    pieces!.add(part);
  }
  return pieces;
}

Future<List<EmployeeModel?>?>? getallIntervenatnsInIntervention(
    List<EmployeeModel?>? employees, int? id) async {
  String url =
      'http://' + hostip + ':8080/getallIntervenatnsInIntervention/$id';
  var data = await http.get(Uri.parse(url));
  var jsonData = json.decode(data.body);
  print(jsonData);
  for (var e in jsonData) {
    EmployeeModel employee = new EmployeeModel();
    employee.id = e["id"];
    employee.firstName = e["firstName"];
    employee.lastName = e["lastName"];
    employee.Email = e["email"];
    employee.tel = e["tel"];
    employees!.add(employee);
  }
  return employees;
}

Future<List<InterventionModel?>> getClientForInterventons(
    List<InterventionModel?> inter) async {
  await Future.forEach<InterventionModel?>(inter, (item) async {
    item!.client = await getClientForInterventon(item.client, item.id);
  });
  print("done client !!!!!!!!!!!!!!!!!!!!!!!! ");
  return inter;
}

Future<List<InterventionModel?>> getMachineForInterventons(
    List<InterventionModel?> inter) async {
  await Future.forEach<InterventionModel?>(inter, (item) async {
    item!.machines = await getAllMachinesinIntervention(item.machines, item.id);
  });
  print("done Machines !!!!!!!!!!!!!!!!!!!!!!!! ");
  return inter;
}

Future<List<InterventionModel?>> getPiecesForInterventons(
    List<InterventionModel?> inter) async {
  await Future.forEach<InterventionModel?>(inter, (item) async {
    item!.pieces = await getallPiecesInIntervention(item.pieces, item.id);
  });
  print("done Pieces !!!!!!!!!!!!!!!!!!!!!!!! ");
  return inter;
}

Future<List<InterventionModel?>> getInterventions() async {
  String url = 'http://' + hostip + ':8080/getallinterventions';
  var data = await http.get(Uri.parse(url));
  var jsonData = json.decode(data.body);
  print(jsonData);
  List<InterventionModel?> interventions = [];
  for (var e in jsonData) {
    InterventionModel? intervention = new InterventionModel();
    intervention.id = e["id"];
    intervention.date = e["date"];
    intervention.duree = e["durée"];
    intervention.descriptionIntervention = e["description_intervention"];
    intervention.natureIntervention = e["nature_intervention"];
    intervention.nbDevice = e["nb_device"];
    intervention.numeroIntervention = e["num_intervention"];
    intervention.observation = e["observation"];
    intervention.machines = [];
    intervention.employees = [];
    intervention.pieces = [];
    interventions.add(intervention);
  }
  return interventions;
}

Future<List<InterventionModel?>> getInterventionsforIntervenant(int? id) async {
  String url =
      'http://' + hostip + ':8080/getallinterventionsforintervention/$id';
  var data = await http.get(Uri.parse(url));
  var jsonData = json.decode(data.body);
  print(jsonData);
  List<InterventionModel?> interventions = [];
  for (var e in jsonData) {
    InterventionModel? intervention = new InterventionModel();
    intervention.id = e["id"];
    intervention.date = e["date"];
    intervention.duree = e["durée"];
    intervention.descriptionIntervention = e["description_intervention"];
    intervention.natureIntervention = e["nature_intervention"];
    intervention.nbDevice = e["nb_device"];
    intervention.numeroIntervention = e["num_intervention"];
    intervention.observation = e["observation"];
    intervention.machines = [];
    intervention.employees = [];
    intervention.pieces = [];
    interventions.add(intervention);
  }
  return interventions;
}

Future<List<InterventionModel?>?> applyChanges(int? id) async {
  List<InterventionModel?> inter = [];
  inter = await getInterventionsforIntervenant(id).then((result) {
    return getClientForInterventons(result).then((result) {
      return getPiecesForInterventons(result).then((result) {
        return getEmployeesForInterventons(result).then((result) {
          return getMachineForInterventons(result);
        });
      });
    });
  });
  return inter;
}

Future<List<InterventionModel?>> getEmployeesForInterventons(
    List<InterventionModel?> inter) async {
  await Future.forEach<InterventionModel?>(inter, (item) async {
    item!.employees =
        await getallIntervenatnsInIntervention(item.employees, item.id);
  });
  print("done IntevenanSts !!!!!!!!!!!!!!!!!!!!!!!! ");
  return inter;
}

class getAllInterventionsForIntervenantState
    extends State<getInterventionsForIntervenants> {
  var interventions = List<InterventionModel?>.generate(200, (index) => null);
  int? idtentifiction;
  final minimumPadding = 5.0;
  getAllInterventionsForIntervenantState(this.idtentifiction);

  TextEditingController searchController = TextEditingController();
  String searchString = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("All Interventions Details"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => adminDrawer()));
            for (var i in interventions) {
              print(i!.date);
            }
          },
        ),
      ),
      body: Container(
        child: FutureBuilder(
          future: applyChanges(this.idtentifiction),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(child: Center(child: Icon(Icons.error)));
            }
            return Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(minimumPadding * 2),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          searchString = value;
                        });
                      },
                      controller: searchController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return snapshot.data[index].numeroIntervention
                                  .toString()
                                  .contains(searchString)
                              ? ListTile(
                                  title: Text('numeroIntervention'),
                                  subtitle: Text(
                                      '${snapshot.data[index].numeroIntervention}'),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DetailPage(
                                                snapshot.data[index])));
                                  },
                                )
                              : Container();
                        }),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  InterventionModel? itervention;

  DetailPage(this.itervention);

  deleteIntervention1(InterventionModel itervention) async {
    final url = Uri.parse('http://' + hostip + ':8080/deleteintervention');
    final request = http.Request("DELETE", url);
    request.headers
        .addAll(<String, String>{"Content-type": "application/json"});
    request.body = jsonEncode(itervention);
    final response = await request.send();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(itervention!.numeroIntervention.toString()),
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
                        builder: (context) => updateIntervention(itervention)));
              })
        ],
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Text(
                'date:' +
                    ' \n' +
                    itervention!.date! +
                    ' \n' +
                    'duree' +
                    ' \n' +
                    itervention!.duree.toString() +
                    ' \n' +
                    'nbDevice' +
                    ' \n' +
                    itervention!.nbDevice.toString() +
                    ' \n' +
                    'descriptionIntervention :' +
                    ' \n' +
                    itervention!.descriptionIntervention! +
                    ' \n' +
                    'natureIntervention :' +
                    ' \n' +
                    itervention!.natureIntervention! +
                    ' \n' +
                    'observation :' +
                    ' \n' +
                    itervention!.observation! +
                    ' \n' +
                    "Client :" +
                    ' \n' +
                    itervention!.client!.firstName.toString() +
                    " " +
                    itervention!.client!.lastName.toString() +
                    ' \n' +
                    "Intervenants :" +
                    ' \n',
                style: TextStyle(fontWeight: FontWeight.bold)),
            for (var i in itervention!.employees!)
              Text(
                  "Intervenant : " +
                      i!.firstName.toString() +
                      " " +
                      i.lastName.toString() +
                      "\n" +
                      "Machines : " +
                      "\n",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            for (var m in itervention!.machines!)
              Text("Machine : " + m!.designation.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold)),
            for (var p in itervention!.pieces!)
              Text(
                  "\n" +
                      "Recharge Parts:" +
                      "\n" +
                      "Recharge Parts : " +
                      p!.designation.toString() +
                      "\n",
                  style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          deleteIntervention1(this.itervention!);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => deleteIntervention()));
        },
        child: Icon(Icons.delete),
        backgroundColor: Colors.pink,
      ),
    );
  }
}
