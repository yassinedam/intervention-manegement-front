import 'dart:convert';

import 'package:employee_management/Model/ClientModel.dart';
import 'package:employee_management/Model/CompanyModel.dart';
import 'package:employee_management/Screens/adminDrawer.dart';
import 'package:employee_management/shared.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class updateCompany extends StatefulWidget {
  CompanyModel? company;

  @override
  State<StatefulWidget> createState() {
    return updateCompanyState(company);
  }

  updateCompany(this.company);
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

Future<CompanyModel?> updateCompanies(
    CompanyModel? company, BuildContext context) async {
  var Url = "http://" + hostip + ":8080/updatecompany";
  var response = await http.put(Uri.parse(Url),
      headers: <String, String>{"Content-Type": "application/json"},
      body: jsonEncode(company));
  print(jsonEncode(company));
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

class updateCompanyState extends State<updateCompany> {
  CompanyModel? company;
  List? clients = [];
  List? slectedClient = [];
  List<ClientModel?> clientss = [];
  Future<List<ClientModel?>?> getAllClientsInCompany(String? mf) async {
    String url = 'http://' + hostip + ':8080/getallclientsincompany/$mf';
    var data = await http.get(Uri.parse(url));
    var jsonData = json.decode(data.body);
    //print(jsonData.toString());
    setState(() {
      clients = jsonData;
    });
  }

  final minimumPadding = 5.0;
  TextEditingController? matricule;
  bool _isEnabled = false;
  TextEditingController? mfController;
  TextEditingController? companynameController;
  TextEditingController? telController;
  TextEditingController? adresseController;

  updateCompanyState(this.company) {
    mfController = TextEditingController(text: this.company!.mf);
    companynameController =
        TextEditingController(text: this.company!.companyname);
    telController = TextEditingController(text: this.company!.tel.toString());
    adresseController = TextEditingController(text: this.company!.adresse);
  }
  @override
  void initState() {
    super.initState();
    print(this.company!.mf);
    getAllClientsInCompany(this.company!.mf);
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
                        controller: mfController,
                        enabled: _isEnabled,
                        validator: (String? value) {
                          if (value != null && value.isEmpty) {
                            return 'please enter the MF';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'MF',
                            hintText: 'Enter the MF',
                            labelStyle: textStyle,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      )),
                  Padding(
                      padding: EdgeInsets.only(
                          top: minimumPadding, bottom: minimumPadding),
                      child: TextFormField(
                        style: textStyle,
                        controller: companynameController,
                        validator: (String? value) {
                          if (value != null && value.isEmpty) {
                            return 'please enter the Company Name';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'the Company Name',
                            hintText: 'Enter the Company Name',
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
                            return 'please enter the Phone Number';
                          }
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: 'the Phone Number',
                            hintText: 'Enter the Phone Number',
                            labelStyle: textStyle,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      )),
                  Padding(
                      padding: EdgeInsets.only(
                          top: minimumPadding, bottom: minimumPadding),
                      child: TextFormField(
                        style: textStyle,
                        controller: adresseController,
                        validator: (String? value) {
                          if (value != null && value.isEmpty) {
                            return 'please enter the Company Adresse';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'the Company Adresse',
                            hintText: 'Enter the Company Adresse',
                            labelStyle: textStyle,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      )),
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: MultiSelectDialogField<String?>(
                      items: clients!.map((list) {
                        return MultiSelectItem<String?>(
                            list["id"].toString(),
                            list["firstname"].toString() +
                                " " +
                                list["lastname"].toString());
                      }).toList(),
                      title: Text("Intervenants"),
                      selectedColor: Colors.blue,
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                        border: Border.all(
                          color: Colors.blue,
                          width: 2,
                        ),
                      ),
                      onConfirm: (results) async {
                        setState(() {
                          slectedClient = results;
                        });
                        clientss = [];
                        ClientModel? client = new ClientModel();
                        for (var c in clients!) {
                          client.id = c["id"];
                          client.firstName = c["firstname"];
                          client.lastName = c["lastname"];
                          client.email = c["email"];
                          client.tel = c["tel"];
                          client.company = c["company"];
                          clientss.add(client);
                        }
                      },
                    ),
                  ),
                  ElevatedButton(
                      child: Text('Update Details'),
                      onPressed: () async {
                        print(clients.toString() +
                            "!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
                        print(clientss.toString() + "**********");
                        String mf = mfController!.text;
                        String companyname = companynameController!.text;
                        String adresse = adresseController!.text;
                        int tel = int.parse(telController!.text);
                        CompanyModel? cmp = new CompanyModel(
                            mf: '', companyname: '', tel: -1, adresse: '');
                        cmp.mf = mf;
                        cmp.companyname = companyname;
                        cmp.tel = tel;
                        cmp.adresse = adresse;
                        cmp.clients = clientss;
                        print(cmp.mf.toString() +
                            ' ' +
                            cmp.companyname.toString() +
                            ' ' +
                            cmp.tel.toString() +
                            ' ' +
                            cmp.adresse.toString() +
                            '!!!');
                        CompanyModel? companies =
                            await updateCompanies(cmp, context);
                        /*print(companies!.mf.toString() +
                            ' ' +
                            companies.companyname.toString() +
                            ' ' +
                            companies.tel.toString() +
                            ' ' +
                            companies.adresse.toString() +
                            '!!!');*/
                        setState(() {
                          company = companies;
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
