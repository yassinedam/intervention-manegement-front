import 'dart:convert';

import 'package:employee_management/Model/ClientModel.dart';
import 'package:employee_management/Model/CompanyModel.dart';
import 'package:employee_management/Screens/Intervention/registerIntervention.dart';
import 'package:employee_management/shared.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class registerClient extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return registerClientState();
  }
}

String hostip = gethost();
Future<CompanyModel?> getCompanybymf(CompanyModel? company, String? mf) async {
  String Url = 'http://' + hostip + ':8080/getcompanybymf/$mf';
  var data = await http.get(Uri.parse(Url));
  var jsonData = json.decode(data.body);
  company = CompanyModel.fromJson(jsonData);
  return company;
}

Future<ClientModel?> registerEmployees(String firstName, String lastName,
    String email, int tel, CompanyModel? company, BuildContext context) async {
  var Url = "http://" + hostip + ":8080/addclient";
  var response = await http.post(Uri.parse(Url),
      headers: <String, String>{"Content-Type": "application/json"},
      body: jsonEncode(<String, dynamic>{
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "tel": tel,
        "company": company,
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

class registerClientState extends State<registerClient> {
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

  TextEditingController firstController = TextEditingController();
  TextEditingController lastController = TextEditingController();
  TextEditingController EmailController = TextEditingController();
  TextEditingController TelController = TextEditingController();
  ClientModel? client;
  CompanyModel? company;
  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.subtitle2;
    return Scaffold(
      appBar: AppBar(
        title: Text("Register Client"),
      ),
      body: Form(
        child: Padding(
          padding: EdgeInsets.all(minimumPadding * 2),
          child: ListView(
            children: <Widget>[
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
                    company = await getCompanybymf(company, selectedcompany);
                    print(company!.mf! +
                        " " +
                        company!.companyName! +
                        " " +
                        company!.adr! +
                        " " +
                        company!.tel.toString());
                  },
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(
                      top: minimumPadding, bottom: minimumPadding),
                  child: TextFormField(
                    style: textStyle,
                    controller: firstController,
                    validator: (String? value) {
                      if (value!.isEmpty) {
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
                      if (value!.isEmpty) {
                        return 'please enter your name';
                      }
                    },
                    decoration: InputDecoration(
                        labelText: 'Last Name',
                        hintText: 'Enter Your Last Name',
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
                      if (value!.isEmpty) {
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
                      if (value!.isEmpty) {
                        return 'please enter your Phone Number';
                      }
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'phone',
                        hintText: 'Enter Your Phone number',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  )),
              RaisedButton(
                  child: Text('Submit'),
                  onPressed: () async {
                    print(company!.mf! +
                        " " +
                        company!.companyName! +
                        " " +
                        company!.adr! +
                        " " +
                        company!.tel.toString());
                    String firstName = firstController.text;
                    String lastName = lastController.text;
                    String email = EmailController.text;
                    int tel = int.parse(TelController.text);
                    ClientModel? clients = await registerEmployees(
                        firstName, lastName, email, tel, company, context);
                    firstController.text = '';
                    lastController.text = '';
                    EmailController.text = '';
                    TelController.text = '';
                    setState(() {
                      client = clients;
                    });
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => registerIntervention()));
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
