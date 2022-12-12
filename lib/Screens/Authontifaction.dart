import 'dart:convert';

import 'package:employee_management/Model/EmployeeModel.dart';
import 'package:employee_management/Model/UserModel.dart';
import 'package:employee_management/Screens/adminDrawer.dart';
import 'package:employee_management/Screens/employeeDrawer.dart';
import 'package:employee_management/shared.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

class Authontifaction extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AuthontifactionState();
  }
}

String hostip = gethost();
Future<UserModel?> getUser(
    UserModel? user, String? username, String? password) async {
  String Url = 'http://' + hostip + ':8080/getuser/$username/$password';
  var data = await http.get(Uri.parse(Url));
  var jsonData = json.decode(data.body);
  user = UserModel.fromJson(jsonData);
  return user;
}

Future<EmployeeModel?> getEmployeeForUser(
    EmployeeModel? employee, int? id) async {
  String Url = 'http://' + hostip + ':8080/getemployeeforuser/$id';
  var data = await http.get(Uri.parse(Url));
  var jsonData = json.decode(data.body);
  employee = EmployeeModel.fromJson(jsonData);
  return employee;
}

class AuthontifactionState extends State<Authontifaction> {
  final minimumPadding = 5.0;
  final maximumPadding = 150.0;
  final maximumPlusPadding = 30.0;
  TextEditingController usernameContoller = TextEditingController();
  TextEditingController passwdController = TextEditingController();
  UserModel? user;
  bool isHidden = true;
  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.subtitle2;
    void togglePasswordVisibility() => setState(() => isHidden = !isHidden);
    return Scaffold(
      appBar: AppBar(
        title: Text("Log in"),
      ),
      body: Form(
        child: Padding(
          padding: EdgeInsets.all(minimumPadding * 2),
          child: ListView(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(
                      top: maximumPadding, bottom: minimumPadding),
                  child: TextFormField(
                    style: textStyle,
                    controller: usernameContoller,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'please Enter the username';
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'the username',
                      hintText: 'Enter the username',
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  )),
              Padding(
                  padding: EdgeInsets.only(
                      top: maximumPlusPadding, bottom: minimumPadding),
                  child: TextFormField(
                    controller: passwdController,
                    obscureText: isHidden,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: isHidden
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility),
                        onPressed: togglePasswordVisibility,
                      ),
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    autofillHints: [AutofillHints.password],
                    onEditingComplete: () => TextInput.finishAutofillContext(),
                    validator: (password) =>
                        password != null && password.length < 5
                            ? 'Enter min. 5 characters'
                            : null,
                  )),
              RaisedButton(
                  child: Text('Submit'),
                  onPressed: () async {
                    String username = usernameContoller.text;
                    String password = passwdController.text;
                    UserModel? users = new UserModel();
                    users = await getUser(users, username, password);
                    users!.employee = new EmployeeModel();
                    print(users.identity);
                    users.employee = await getEmployeeForUser(
                        users.employee, users.identity);
                    usernameContoller.text = '';
                    passwdController.text = '';
                    setState(() {
                      user = users;
                    });
                    print(user!.rank);
                    print(user!.employee!.id);
                    if (user!.rank == 0) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => adminDrawer()));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  employeeDrawer(user!.employee!.id)));
                    }
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
