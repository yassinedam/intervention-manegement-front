import 'dart:convert';

import 'package:employee_management/Model/UserModel.dart';
import 'package:employee_management/Screens/User/deleteUser.dart';
import 'package:employee_management/Screens/User/updateUsers.dart';
import 'package:employee_management/Screens/adminDrawer.dart';
import 'package:employee_management/shared.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class getUsers extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return getAllUsersState();
  }
}

String hostip = gethost();

class getAllUsersState extends State<getUsers> {
  var userss = List<UserModel?>.generate(200, (index) => null);
  Future<List<UserModel?>?> getAllUsers() async {
    String url = 'http://' + hostip + ':8080/getallusers';
    var data = await http.get(Uri.parse(url));
    var jsonData = json.decode(data.body);
    print(jsonData);
    List<UserModel?> users = [];
    for (var e in jsonData) {
      UserModel? user = new UserModel();
      user.identity = e["identity"];
      user.userName = e["userName"];
      user.password = e["password"];
      user.rank = e["rank"];
      user.tel = e["tel"];
      users.add(user);
    }
    print(users.toList().toString());
    return users;
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
        child: FutureBuilder<List<UserModel?>?>(
          future: getAllUsers(),
          builder: (BuildContext context,
              AsyncSnapshot<List<UserModel?>?> snapshot) {
            if (snapshot.data == null) {
              return Container(child: Center(child: Icon(Icons.error)));
            }
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text('UserName'),
                    subtitle: Text('${snapshot.data![index]!.userName}'),
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
    );
  }
}

class DetailPage extends StatelessWidget {
  UserModel? user;

  DetailPage(this.user);
  deleteUser1(UserModel? user) async {
    final url = Uri.parse('http://' + hostip + ':8080/deleteuser');
    final request = http.Request("DELETE", url);
    request.headers
        .addAll(<String, String>{"Content-type": "application/json"});
    request.body = jsonEncode(user);
    final response = await request.send();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user!.userName.toString()),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.edit,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => updateUser(user)));
              })
        ],
      ),
      body: Container(
        child: Text('!id :' +
            ' \n' +
            user!.identity.toString() +
            ' \n' +
            'UserName :' +
            ' \n' +
            user!.userName.toString() +
            ' \n' +
            'password :' +
            ' \n' +
            user!.password.toString() +
            ' \n' +
            'rank' +
            ' \n' +
            user!.rank.toString() +
            ' \n' +
            'Date :' +
            user!.tel.toString()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          deleteUser1(this.user);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => deleteUser()));
        },
        child: Icon(Icons.delete),
        backgroundColor: Colors.pink,
      ),
    );
  }
}
