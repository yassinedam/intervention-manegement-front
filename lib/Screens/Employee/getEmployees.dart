import 'dart:convert';

import 'package:employee_management/Model/EmployeeModel.dart';
import 'package:employee_management/Screens/Employee/deleteEmployee.dart';
import 'package:employee_management/Screens/Employee/registerEmployee.dart';
import 'package:employee_management/Screens/adminDrawer.dart';
import 'package:employee_management/Screens/Employee/updateEmployees.dart';
import 'package:employee_management/shared.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class getemployees extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return getAllEmployeesState();
  }
}

String hostip = gethost();

class getAllEmployeesState extends State<getemployees> {
  var employess = List<EmployeeModel?>.generate(200, (index) => null);

  Future<List<EmployeeModel>> getEmployees() async {
    String url = 'http://' + hostip + ':8080/getallemployees';
    var data = await http.get(Uri.parse(url));
    var jsonData = json.decode(data.body);

    List<EmployeeModel> employee = [];
    for (var e in jsonData) {
      EmployeeModel employees = new EmployeeModel();
      employees.id = e["id"];
      employees.firstName = e["firstName"];
      employees.lastName = e["lastName"];
      employees.Email = e["Email"];
      employees.tel = e["Tel"];
      employee.add(employees);
    }
    return employee;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("All Employees Details"),
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
                    title: Text('ID' +
                        ' ' +
                        'First Name' +
                        ' ' +
                        'Last Name' +
                        ' ' +
                        'Eamil' +
                        ' ' +
                        'Phone Number'),
                    subtitle: Text('${snapshot.data[index].id}' +
                        ' ' +
                        '${snapshot.data[index].firstName}' +
                        ' ' +
                        '${snapshot.data[index].lastName}' +
                        ' ' +
                        '${snapshot.data[index].Email}' +
                        ' ' +
                        '${snapshot.data[index].tel}'),
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
              MaterialPageRoute(builder: (context) => registerEmployee()));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  EmployeeModel? employee;

  DetailPage(this.employee);

  deleteEmployee1(EmployeeModel employee) async {
    final url = Uri.parse('http://' + hostip + ':8080/deleteemployee');
    final request = http.Request("DELETE", url);
    request.headers
        .addAll(<String, String>{"Content-type": "application/json"});
    request.body = jsonEncode(employee);
    final response = await request.send();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(employee!.firstName! + ' ' + employee!.lastName!),
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
                        builder: (context) => updateEmployee(employee)));
              })
        ],
      ),
      body: Container(
        child: Text('FirstName' +
            ' ' +
            employee!.firstName! +
            ' ' +
            'LastName' +
            employee!.lastName! +
            ' ' +
            'Eamail' +
            employee!.Email! +
            ' ' +
            'Phone number ' +
            employee!.tel.toString()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          deleteEmployee1(this.employee!);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => deleteEmployee()));
        },
        child: Icon(Icons.delete),
        backgroundColor: Colors.pink,
      ),
    );
  }
}
