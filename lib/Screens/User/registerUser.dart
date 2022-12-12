import 'dart:convert';

import 'package:employee_management/Model/EmployeeModel.dart';
import 'package:employee_management/Model/UserModel.dart';
import 'package:employee_management/shared.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class registerUser extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return registerUserState();
  }
}

Future<EmployeeModel?> getEmployeeForUser(
    EmployeeModel? employee, int? id) async {
  String Url = 'http://' + hostip + ':8080/getemployeebyid/$id';
  var data = await http.get(Uri.parse(Url));
  var jsonData = json.decode(data.body);
  employee = EmployeeModel.fromJson(jsonData);
  return employee;
}

String hostip = gethost();
Future<UserModel?> registerUsers(
    int identity,
    String userName,
    int rank,
    String password,
    int tel,
    EmployeeModel? employee,
    BuildContext context) async {
  var Url = "http://" + hostip + ":8080/adduser";
  var response = await http.post(Uri.parse(Url),
      headers: <String, String>{"Content-Type": "application/json"},
      body: jsonEncode(<String, dynamic>{
        "identity": identity,
        "userName": userName,
        "rank": rank,
        "password": password,
        "tel": tel,
        "employee": employee,
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

class registerUserState extends State<registerUser> {
  final minimumPadding = 5.0;

  TextEditingController? idController = TextEditingController();
  TextEditingController? userNameController = TextEditingController();
  TextEditingController? passwordController = TextEditingController();
  TextEditingController? rankController = TextEditingController();
  TextEditingController? telController = TextEditingController();
  UserModel? user;
  EmployeeModel? employee;
  List? employees = [];
  int? selectedClient;
  Future<List<EmployeeModel?>?> getAllEmployees() async {
    String url = 'http://' + hostip + ':8080/getallemployees';
    var data = await http.get(Uri.parse(url));
    var jsonData = json.decode(data.body);
    setState(() {
      employees = jsonData;
    });
  }

  bool isHidden = false;
  @override
  void initState() {
    super.initState();
    getAllEmployees();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.subtitle2;
    void togglePasswordVisibility() => setState(() => isHidden = !isHidden);
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
                    controller: idController,
                    validator: (String? value) {
                      if (value != null && value.isEmpty) {
                        return 'please enter the user id';
                      }
                    },
                    decoration: InputDecoration(
                        labelText: 'the user id',
                        hintText: 'Enter the user id',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  )),
              Padding(
                  padding: EdgeInsets.only(
                      top: minimumPadding, bottom: minimumPadding),
                  child: TextFormField(
                    style: textStyle,
                    controller: userNameController,
                    validator: (String? value) {
                      if (value != null && value.isEmpty) {
                        return 'please enter the full name of the user';
                      }
                    },
                    decoration: InputDecoration(
                        labelText: 'the full name of the user',
                        hintText: 'Enter the full name of the user',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  )),
              Padding(
                  padding: EdgeInsets.only(
                      top: minimumPadding, bottom: minimumPadding),
                  child: TextFormField(
                    controller: passwordController,
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
              Padding(
                  padding: EdgeInsets.only(
                      top: minimumPadding, bottom: minimumPadding),
                  child: TextFormField(
                    style: textStyle,
                    controller: rankController,
                    validator: (String? value) {
                      if (value != null && value.isEmpty) {
                        return 'please enter the rank of the user';
                      }
                    },
                    decoration: InputDecoration(
                        labelText: 'the rank of the user',
                        hintText: 'Enter the rank of the user',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  )),
              Padding(
                  padding: EdgeInsets.only(
                      top: minimumPadding, bottom: minimumPadding),
                  child: TextFormField(
                    style: textStyle,
                    controller: telController,
                    validator: (String? value) {
                      if (value != null && value.isEmpty) {
                        return 'please enter The Phone number';
                      }
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'The Phone number',
                        hintText: 'Enter The Phone number',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  )),
              SizedBox(
                height: 30,
              ),
              Center(
                child: DropdownButton(
                  isExpanded: true,
                  value: selectedClient,
                  hint: Text("Select Name"),
                  items: employees!.map((list) {
                    return DropdownMenuItem(
                      child: Text(list["firstName"] + " " + list["lastName"],
                          overflow: TextOverflow.ellipsis),
                      value: list["id"],
                    );
                  }).toList(),
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  onChanged: (dynamic value) async {
                    setState(() {
                      selectedClient = value;
                    });
                    employee =
                        await getEmployeeForUser(employee, selectedClient);
                    print(employee!.firstName!.toString() +
                        " " +
                        employee!.lastName!.toString());
                  },
                ),
              ),
              RaisedButton(
                  child: Text('Submit'),
                  onPressed: () async {
                    print(employee!.firstName!.toString() +
                        " " +
                        employee!.lastName!.toString());
                    int id = int.parse(idController!.text);
                    String username = userNameController!.text;
                    String passwd = passwordController!.text;
                    int rank = int.parse(rankController!.text);
                    int tel = int.parse(telController!.text);
                    UserModel? users = await registerUsers(
                        id, username, rank, passwd, tel, employee, context);
                    idController!.text = '';
                    userNameController!.text = '';
                    passwordController!.text = '';
                    rankController!.text = '';
                    telController!.text = '';
                    setState(() {
                      user = users;
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
