import 'dart:convert';

import 'package:employee_management/Model/ClientModel.dart';
import 'package:employee_management/Model/CompanyModel.dart';
import 'package:employee_management/Screens/Client/deleteClient.dart';
import 'package:employee_management/Screens/Client/registerClient.dart';
import 'package:employee_management/Screens/adminDrawer.dart';
import 'package:employee_management/Screens/Client/updateClient.dart';
import 'package:employee_management/shared.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class getClients extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return getAllClientsState();
  }
}

String hostip = gethost();
Future<CompanyModel?> getCompanybyClientid(
    CompanyModel? company, int? id) async {
  String url = 'http://' + hostip + ':8080/getcompanybyclientid/$id';
  var data = await http.get(Uri.parse(url));
  var jsonData = json.decode(data.body);
  company = CompanyModel.fromJson(jsonData);
  return company;
}

class getAllClientsState extends State<getClients> {
  var clientss = List<ClientModel?>.generate(200, (index) => null);
  String url = 'http://' + hostip + ':8080/getallclients';
  List<ClientModel?> client = [];
  Future<List<ClientModel?>?> getClients() async {
    var data = await http.get(Uri.parse(url));
    var jsonData = json.decode(data.body);
    print(jsonData);
    List<ClientModel?> clts = [];
    for (var e in jsonData) {
      ClientModel? clients = new ClientModel();
      clients.id = e["id"];
      clients.firstName = e["firstname"];
      clients.lastName = e["lastname"];
      clients.email = e["email"];
      clients.tel = e["tel"];
      clts.add(clients);
    }
    print(clts.toList().toString());
    setState(() {
      client = clts;
    });
  }

  Future<List<ClientModel?>?> getCompaniesForClients() async {
    List<ClientModel?> clts = [];
    await Future.forEach<ClientModel?>(client, (item) async {
      item!.company = await getCompanybyClientid(item.company, item.id);
    });
    /* for (var c in client) {
      c.company = await getCompanybyClientid(c.company, c.id);
    }*/
    clts = client;
    return clts;
  }

  @override
  void initState() {
    super.initState();
    getClients();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("All Clients Details"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => adminDrawer()));
          },
        ),
      ),
      body: Container(
        child: FutureBuilder<List<ClientModel?>?>(
          future: getCompaniesForClients(),
          builder: (BuildContext context,
              AsyncSnapshot<List<ClientModel?>?> snapshot) {
            if (snapshot.data == null) {
              return Container(child: Center(child: Icon(Icons.error)));
            }
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text('First Name' + ' ' + 'Last Name' + ' '),
                    subtitle: Text('${snapshot.data![index]!.firstName}' +
                        ' ' +
                        '${snapshot.data![index]!.lastName}'),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DetailPage(snapshot.data![index])));
                      print(snapshot.data![index]!.firstName.toString() +
                          " " +
                          snapshot.data![index]!.getcompanyName().toString());
                    },
                  );
                });
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => registerClient()));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  ClientModel? client;

  DetailPage(this.client);
  deleteEmployee1(ClientModel? client) async {
    final url = Uri.parse('http://' + hostip + ':8080/deleteclient');
    final request = http.Request("DELETE", url);
    request.headers
        .addAll(<String, String>{"Content-type": "application/json"});
    request.body = jsonEncode(client);
    final response = await request.send();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            client!.firstName.toString() + " " + client!.lastName.toString()),
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
                        builder: (context) => updateClient(client)));
              })
        ],
      ),
      body: Container(
        child: Text('FirstName :' +
            ' \n' +
            client!.firstName.toString() +
            ' \n' +
            'LastName :' +
            ' \n' +
            client!.lastName.toString() +
            ' \n' +
            'Email :' +
            ' \n' +
            client!.email.toString() +
            ' \n' +
            'Phone number :' +
            ' \n' +
            client!.tel.toString() +
            ' \n' +
            'Company :' +
            client!.getcompanyName().toString()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          deleteClient();
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => deleteClient()));
        },
        child: Icon(Icons.delete),
        backgroundColor: Colors.pink,
      ),
    );
  }
}
