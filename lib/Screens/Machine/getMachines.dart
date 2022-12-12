import 'dart:convert';

import 'package:employee_management/Model/MachineModel.dart';
import 'package:employee_management/Screens/Machine/deleteMachine.dart';
import 'package:employee_management/Screens/Machine/registerMachine.dart';
import 'package:employee_management/Screens/adminDrawer.dart';
import 'package:employee_management/Screens/Machine/updateMachine.dart';
import 'package:employee_management/shared.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class getMachines extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return getAllMachinesState();
  }
}

String hostip = gethost();

class getAllMachinesState extends State<getMachines> {
  var Machiness = List<MachineModel?>.generate(200, (index) => null);
  Future<List<MachineModel?>?> getAllMachines() async {
    String url = 'http://' + hostip + ':8080/getallmachines';
    var data = await http.get(Uri.parse(url));
    var jsonData = json.decode(data.body);
    print(jsonData);
    List<MachineModel?> machines = [];
    for (var e in jsonData) {
      MachineModel? machine = new MachineModel();
      machine.code = e["code"];
      machine.designation = e["designation"];
      machine.qteDisp = e["qté_Disp"];
      machine.qteStock = e["qté_Stock"];
      machine.qteEnInstance = e["qté_en_instance"];
      machines.add(machine);
    }
    print(machines.toList().toString());
    return machines;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("All Machine Details"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => adminDrawer()));
          },
        ),
      ),
      body: Container(
        child: FutureBuilder<List<MachineModel?>?>(
          future: getAllMachines(),
          builder: (BuildContext context,
              AsyncSnapshot<List<MachineModel?>?> snapshot) {
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
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => registerMachine()));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  MachineModel? machine;

  DetailPage(this.machine);
  deleteMachine1(MachineModel? machine) async {
    final url = Uri.parse('http://' + hostip + ':8080/deletemachine');
    final request = http.Request("DELETE", url);
    request.headers
        .addAll(<String, String>{"Content-type": "application/json"});
    request.body = jsonEncode(machine);
    final response = await request.send();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(machine!.designation.toString()),
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
                        builder: (context) => updateMachine(machine)));
              })
        ],
      ),
      body: Container(
        child: Text('Code :' +
            ' \n' +
            machine!.code.toString() +
            ' \n' +
            'Designation :' +
            ' \n' +
            machine!.designation.toString() +
            ' \n' +
            'Quntitée disponible :' +
            ' \n' +
            machine!.qteDisp.toString() +
            ' \n' +
            'Quntitée en Stock :' +
            ' \n' +
            machine!.qteStock.toString() +
            ' \n' +
            'Quntitée en Instance :' +
            machine!.qteEnInstance.toString()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          deleteMachine1(this.machine);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => deleteMachine()));
        },
        child: Icon(Icons.delete),
        backgroundColor: Colors.pink,
      ),
    );
  }
}
