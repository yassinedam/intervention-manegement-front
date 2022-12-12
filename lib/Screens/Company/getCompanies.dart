import 'dart:convert';

import 'package:employee_management/Model/CompanyModel.dart';
import 'package:employee_management/Model/EmployeeModel.dart';
import 'package:employee_management/Screens/Company/deleteCompany.dart';
import 'package:employee_management/Screens/Company/registerCompany.dart';
import 'package:employee_management/Screens/adminDrawer.dart';
import 'package:employee_management/Screens/Company/updateCompany.dart';
import 'package:employee_management/shared.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class getCompanies extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return getAllCompaniesState();
  }
}

String hostip = gethost();

class getAllCompaniesState extends State<getCompanies> {
  var employess = List<EmployeeModel?>.generate(200, (index) => null);

  Future<List<CompanyModel>> getEmployees() async {
    String url = 'http://' + hostip + ':8080/getallcompanies';
    var data = await http.get(Uri.parse(url));
    var jsonData = json.decode(data.body);
    print(jsonData);
    List<CompanyModel> companies = [];
    for (var e in jsonData) {
      CompanyModel company = new CompanyModel();
      company.mf = e["mf"];
      company.companyname = e["companyName"];
      company.tel = e["tel"];
      company.adresse = e["adresse"];
      companies.add(company);
    }
    return companies;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("All Companies Details"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => adminDrawer()));
          },
        ),
      ),
      body: Container(
        child: FutureBuilder(
          future: getEmployees(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(child: Center(child: Icon(Icons.error)));
            }
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text('Mf' +
                        ' ' +
                        'CompanyName' +
                        ' ' +
                        'PhoneNumber' +
                        ' ' +
                        'Adresse'),
                    subtitle: Text('${snapshot.data[index].mf}' +
                        ' ' +
                        '${snapshot.data[index].companyName}' +
                        ' ' +
                        '${snapshot.data[index].tel}' +
                        ' ' +
                        '${snapshot.data[index].adresse}'),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DetailPage(snapshot.data[index])));
                    },
                  );
                });
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => registerCompany()));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  CompanyModel? company;

  DetailPage(this.company);

  deleteCompany1(CompanyModel company) async {
    final url = Uri.parse('http://' + hostip + ':8080/deletecompany');
    final request = http.Request("DELETE", url);
    request.headers
        .addAll(<String, String>{"Content-type": "application/json"});
    request.body = jsonEncode(company);
    final response = await request.send();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(company!.companyname!),
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
                        builder: (context) => updateCompany(company)));
              })
        ],
      ),
      body: Container(
        child: Text(
            'MF:' +
                ' \n' +
                company!.mf! +
                ' \n' +
                'company Name:' +
                ' \n' +
                company!.companyname! +
                ' \n' +
                'Phone Number:' +
                ' \n' +
                company!.tel.toString() +
                ' \n' +
                'Adresse :' +
                ' \n' +
                company!.adresse!,
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          deleteCompany1(this.company!);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => deleteCompany()));
        },
        child: Icon(Icons.delete),
        backgroundColor: Colors.pink,
      ),
    );
  }
}
