import 'dart:convert';
import 'dart:ffi';

import 'package:employee_management/Model/UserModel.dart';
import 'package:employee_management/Screens/adminDrawer.dart';
import 'package:employee_management/shared.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class updateUser extends StatefulWidget {
  UserModel? user;

  @override
  State<StatefulWidget> createState() {
    return updateUserState(user);
  }

  updateUser(this.user);
}

String hostip = gethost();
Future<UserModel?>? updateUsers(UserModel user, BuildContext context) async {
  var Url = "http://" + hostip + ":8080/updateuser";
  var response = await http.put(Uri.parse(Url),
      headers: <String, String>{"Content-Type": "application/json"},
      body: jsonEncode(user));
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

class updateUserState extends State<updateUser> {
  UserModel? user;
  final minimumPadding = 5.0;
  TextEditingController? idController;
  bool _isEnabled = false;
  TextEditingController? userNameController;
  TextEditingController? passwordController;
  TextEditingController? rankController;
  TextEditingController? telController;
  bool isHidden = false;
  updateUserState(this.user) {
    idController = TextEditingController(text: this.user!.identity.toString());
    userNameController = TextEditingController(text: this.user!.userName);
    passwordController = TextEditingController(text: this.user!.password);
    rankController = TextEditingController(text: this.user!.rank.toString());
    telController = TextEditingController(text: this.user!.tel.toString());
  }

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.subtitle2;
    return Scaffold(
        appBar: AppBar(
          title: Text('Update User'),
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
                        controller: idController,
                        enabled: _isEnabled,
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
                        style: textStyle,
                        obscureText: true,
                        controller: passwordController,
                        validator: (String? value) {
                          if (value != null && value.isEmpty) {
                            return 'please enter The new password';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'The new password',
                            hintText: 'Enter The new password',
                            labelStyle: textStyle,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
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
                  ElevatedButton(
                      child: Text('Update Details'),
                      onPressed: () async {
                        int id = int.parse(idController!.text);
                        String username = userNameController!.text;
                        String passwd = passwordController!.text;
                        int rank = int.parse(rankController!.text);
                        int tel = int.parse(telController!.text);
                        UserModel? usr = new UserModel();
                        usr.identity = id;
                        usr.userName = username;
                        usr.password = passwd;
                        usr.rank = rank;
                        usr.tel = tel;
                        UserModel? users = await updateUsers(usr, context);
                        setState(() {
                          user = users;
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
