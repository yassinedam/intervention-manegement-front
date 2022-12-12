import 'dart:convert';

import 'package:employee_management/Model/ClientModel.dart';
import 'package:employee_management/Model/CompanyModel.dart';
import 'package:employee_management/Screens/adminDrawer.dart';
import 'package:employee_management/shared.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class updateClient extends StatefulWidget {
  ClientModel? client;

  @override
  State<StatefulWidget> createState() {
    return updateClientState(client);
  }

  updateClient(this.client);
}

String hostip = gethost();
Future<CompanyModel?> getCompanybymf(CompanyModel? company, String? mf) async {
  String url = 'http://' + hostip + ':8080/getcompanybymf/$mf';
  var data = await http.get(Uri.parse(url));
  var jsonData = json.decode(data.body);
  print(jsonData.toString());
  company = CompanyModel.fromJson(jsonData);
  print(company.mf.toString() +
      " " +
      company.companyName.toString() +
      " " +
      company.adr.toString() +
      " " +
      company.tel.toString());
  return company;
}

Future<ClientModel?> updateClinets(
    ClientModel client, BuildContext context) async {
  var Url = "http://1" + hostip + ":8080/updateclient";
  var response = await http.put(Uri.parse(Url),
      headers: <String, String>{"Content-Type": "application/json"},
      body: jsonEncode(client));
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

class updateClientState extends State<updateClient> {
  ClientModel? client;
  final minimumPadding = 5.0;
  String? selectedcompany;
  List? companies = [];
  Future<List<CompanyModel?>?> getAllcompanies() async {
    String url = 'http://' + hostip + ':8080/getallcompanies';
    var data = await http.get(Uri.parse(url));
    var jsonData = json.decode(data.body);

    setState(() {
      companies = jsonData;
    });
  }

  @override
  void initState() {
    super.initState();
    getAllcompanies();
  }

  TextEditingController? employeeNumber;
  bool _isEnabled = false;
  TextEditingController? firstController;
  TextEditingController? lastController;
  TextEditingController? EmailController;
  TextEditingController? TelController;
  CompanyModel? company;

  updateClientState(this.client) {
    employeeNumber = TextEditingController(text: this.client!.id.toString());
    firstController = TextEditingController(text: this.client!.firstName);
    lastController = TextEditingController(text: this.client!.lastName);
    EmailController = TextEditingController(text: this.client!.Email);
    TelController = TextEditingController(text: this.client!.tel.toString());
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
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: DropdownButton(
                      isExpanded: true,
                      value: selectedcompany,
                      hint: Text("Select Company"),
                      items: companies!.map((list) {
                        return DropdownMenuItem(
                          child: Text(list["companyName"],
                              overflow: TextOverflow.ellipsis),
                          value: list["mf"],
                        );
                      }).toList(),
                      onChanged: (dynamic value) async {
                        setState(() {
                          selectedcompany = value;
                        });
                        print(selectedcompany);
                        company =
                            await getCompanybymf(company, selectedcompany);
                        print(company!.mf.toString() +
                            " " +
                            company!.companyName.toString() +
                            " " +
                            company!.adr.toString() +
                            " " +
                            company!.tel.toString());
                      },
                    ),
                  ),
                  ElevatedButton(
                      child: Text('Update Details'),
                      onPressed: () async {
                        String id = employeeNumber!.text;
                        String firstName = firstController!.text;
                        String lastName = lastController!.text;
                        String email = EmailController!.text;
                        String tel = TelController!.text;
                        ClientModel? clt = new ClientModel(
                            firstName: '', id: -1, lastName: '');
                        clt.id = int.parse(id);
                        clt.firstName = firstName;
                        clt.lastName = lastName;
                        clt.email = email;
                        clt.tel = int.parse(tel);
                        clt.company = company;
                        ClientModel? clients =
                            await updateClinets(clt, context);
                        setState(() {
                          client = clients;
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
