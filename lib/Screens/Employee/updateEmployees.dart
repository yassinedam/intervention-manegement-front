import 'dart:convert';

import 'package:employee_management/Model/EmployeeModel.dart';
import 'package:employee_management/Screens/adminDrawer.dart';
import 'package:employee_management/shared.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class updateEmployee extends StatefulWidget {
  EmployeeModel? employee;

  @override
  State<StatefulWidget> createState() {
    return updateEmployeeState(employee);
  }

  updateEmployee(this.employee);
}

String hostip = gethost();
Future<EmployeeModel?> updateEmployees(
    EmployeeModel employee, BuildContext context) async {
  var Url = "http://" + hostip + ":8080/updateemployee";
  var response = await http.put(Uri.parse(Url),
      headers: <String, String>{"Content-Type": "application/json"},
      body: jsonEncode(employee));
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

class updateEmployeeState extends State<updateEmployee> {
  EmployeeModel? employee;
  final minimumPadding = 5.0;
  TextEditingController? employeeNumber;
  bool _isEnabled = false;
  TextEditingController? firstController;
  TextEditingController? lastController;
  TextEditingController? EmailController;
  TextEditingController? TelController;
  Future<List<EmployeeModel>>? employees;

  updateEmployeeState(this.employee) {
    employeeNumber = TextEditingController(text: this.employee!.id.toString());
    firstController = TextEditingController(text: this.employee!.firstName);
    lastController = TextEditingController(text: this.employee!.lastName);
    EmailController = TextEditingController(text: this.employee!.Email);
    TelController = TextEditingController(text: this.employee!.tel.toString());
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
                        controller: employeeNumber,
                        enabled: _isEnabled,
                        validator: (String? value) {
                          if (value != null && value.isEmpty) {
                            return 'please enter your ID';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'Employee ID',
                            hintText: 'Enter Employee ID',
                            labelStyle: textStyle,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      )),
                  Padding(
                      padding: EdgeInsets.only(
                          top: minimumPadding, bottom: minimumPadding),
                      child: TextFormField(
                        style: textStyle,
                        controller: firstController,
                        validator: (String? value) {
                          if (value != null && value.isEmpty) {
                            return 'please enter your name';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'First Name',
                            hintText: 'Enter Your First Name',
                            labelStyle: textStyle,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      )),
                  Padding(
                      padding: EdgeInsets.only(
                          top: minimumPadding, bottom: minimumPadding),
                      child: TextFormField(
                        style: textStyle,
                        controller: lastController,
                        validator: (String? value) {
                          if (value != null && value.isEmpty) {
                            return 'please enter your name';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'Last Name',
                            hintText: 'Enter Your First Name',
                            labelStyle: textStyle,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      )),
                  Padding(
                      padding: EdgeInsets.only(
                          top: minimumPadding, bottom: minimumPadding),
                      child: TextFormField(
                        style: textStyle,
                        controller: EmailController,
                        validator: (String? value) {
                          if (value != null && value.isEmpty) {
                            return 'please enter your Email';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'Email',
                            hintText: 'Enter Your Email',
                            labelStyle: textStyle,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      )),
                  Padding(
                      padding: EdgeInsets.only(
                          top: minimumPadding, bottom: minimumPadding),
                      child: TextFormField(
                        style: textStyle,
                        controller: TelController,
                        validator: (String? value) {
                          if (value != null && value.isEmpty) {
                            return 'please enter your Phone Number';
                          }
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: 'Phone Number',
                            hintText: 'Enter Your Phone Number',
                            labelStyle: textStyle,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      )),
                  ElevatedButton(
                      child: Text('Update Details'),
                      onPressed: () async {
                        String firstName = firstController!.text;
                        String lastName = lastController!.text;
                        String Email = EmailController!.text;
                        int Tel = int.parse(TelController!.text);
                        EmployeeModel emp = new EmployeeModel(
                            firstName: '', id: -1, lastName: '');
                        emp.id = employee!.id;
                        emp.firstName = firstName;
                        emp.lastName = lastName;
                        emp.Email = Email;
                        emp.tel = Tel;
                        EmployeeModel? employees =
                            await updateEmployees(emp, context);
                        setState(() {
                          employee = employees;
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
