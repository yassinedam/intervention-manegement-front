import 'dart:convert';

import 'package:employee_management/Model/InterventionModel.dart';
import 'package:employee_management/Model/EmployeeModel.dart';
import 'package:employee_management/Model/MachineModel.dart';
import 'package:employee_management/Model/ClientModel.dart';
import 'package:employee_management/Model/PieceDeReChargeModel.dart';
import 'package:employee_management/shared.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:multiselect/multiselect.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class registerIntervention extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return registerInterventionState();
  }
}

String hostip = gethost();
Future<ClientModel?> getClientById(ClientModel? client, int? id) async {
  String Url = 'http://' + hostip + ':8080/getclient/$id';
  var data = await http.get(Uri.parse(Url));
  var jsonData = json.decode(data.body);
  client = ClientModel.fromJson(jsonData);
  return client;
}

Future<MachineModel?>? getMachineBycode(
    MachineModel? machine, String? code) async {
  String Url = 'http://' + hostip + ':8080/getmachinebycode/$code';
  var data = await http.get(Uri.parse(Url));
  var jsonData = json.decode(data.body);
  machine = MachineModel.fromJson(jsonData);
  return machine;
}

Future<PieceDeReChargeModel?> getPiecebyCode(
    PieceDeReChargeModel? piece, String? code) async {
  String url = 'http://' + hostip + ':8080/getpiecebyCode/$code';
  var data = await http.get(Uri.parse(url));
  var jsonData = json.decode(data.body);
  piece = PieceDeReChargeModel.fromJson(jsonData);
  return piece;
}

Future<EmployeeModel?> getEmployeebyId(EmployeeModel? employee, int id) async {
  String url = 'http://' + hostip + ':8080/getemployeebyid/$id';
  var data = await http.get(Uri.parse(url));
  var jsonData = json.decode(data.body);
  employee = EmployeeModel.fromJson(jsonData);
  return employee;
}

Future<InterventionModel?> registerInterventions(
    String date,
    int duree,
    int numeroIntervention,
    int nbDevice,
    String natureIntervention,
    String descriptionIntervention,
    String observation,
    ClientModel? client,
    List<EmployeeModel?>? employee,
    List<MachineModel?>? machine,
    List<PieceDeReChargeModel?>? piece,
    BuildContext context) async {
  var Url = "http://" + hostip + ":8080/addintervention";
  var response = await http.post(Uri.parse(Url),
      headers: <String, String>{"Content-Type": "application/json"},
      body: jsonEncode(<String, dynamic>{
        "client": client,
        "date": date,
        "durée": duree,
        "num_intervention": numeroIntervention,
        "nb_device": nbDevice,
        "nature_intervention": natureIntervention,
        "description_intervention": descriptionIntervention,
        "observation": observation,
        "client": client,
        "intervenants": employee,
        "machines": machine,
        "piece_de_recharge": piece
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

class registerInterventionState extends State<registerIntervention> {
  List<String?> selectedemployees = [];
  List<String?> selectedmachines = [];
  List<String?> selectedpieces = [];
  int? selectedClient;
  List? employees = [];
  List? machines = [];
  List? pieces = [];
  List? clients = [];
  Future<List<EmployeeModel?>?> getAllEmployees() async {
    String url = 'http://' + hostip + ':8080/getallemployees';
    var data = await http.get(Uri.parse(url));
    var jsonData = json.decode(data.body);

    setState(() {
      employees = jsonData;
    });
  }

  Future<List<ClientModel?>?> getAllClients() async {
    String url = 'http://' + hostip + ':8080/getallclients';
    var data = await http.get(Uri.parse(url));
    var jsonData = json.decode(data.body);

    setState(() {
      clients = jsonData;
    });
    print(clients.toString());
  }

  Future<List<MachineModel?>?> getAllMachines() async {
    String url = 'http://' + hostip + ':8080/getallmachines';
    var data = await http.get(Uri.parse(url));
    var jsonData = json.decode(data.body);

    setState(() {
      machines = jsonData;
    });
  }

  Future<List<PieceDeReChargeModel?>?> getAllPieces() async {
    String url = 'http://' + hostip + ':8080/getallpieces';
    var data = await http.get(Uri.parse(url));
    var jsonData = json.decode(data.body);

    setState(() {
      pieces = jsonData;
    });
  }

  @override
  void initState() {
    super.initState();
    getAllClients();
    getAllEmployees();
    getAllMachines();
    getAllPieces();
  }

  final minimumPadding = 5.0;

  TextEditingController dateController = TextEditingController();
  TextEditingController dureeController = TextEditingController();
  TextEditingController numeroInterventionController = TextEditingController();
  TextEditingController nbDeviceController = TextEditingController();
  TextEditingController natureInterventionController = TextEditingController();
  TextEditingController descriptionInterventionController =
      TextEditingController();
  TextEditingController observationController = TextEditingController();
  InterventionModel? intervention;
  ClientModel? client;
  List<MachineModel?> machiness = [];
  List<EmployeeModel?> employess = [];
  List<PieceDeReChargeModel?> piecess = [];
  DateTime? dateTime;

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.subtitle2;
    return Scaffold(
      appBar: AppBar(
        title: Text("Register Intervention"),
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
                  value: selectedClient,
                  hint: Text("Select Name"),
                  items: clients!.map((list) {
                    return DropdownMenuItem(
                      child: Text(list["firstname"] + " " + list["lastname"],
                          overflow: TextOverflow.ellipsis),
                      value: list["id"],
                    );
                  }).toList(),
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  onChanged: (dynamic value) async {
                    setState(() {
                      selectedClient = value;
                    });
                    client = await getClientById(client, selectedClient);
                    print(client!.firstName.toString() +
                        " " +
                        client!.lastName.toString());
                  },
                ),
              ),
              /*!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!*/
              Text(dateTime == null
                  ? 'Nothing has been picked yet'
                  : DateFormat('dd-MM-yyyy').format(dateTime!)),
              RaisedButton(
                child: Text('Pick a date'),
                onPressed: () {
                  showDatePicker(
                          context: context,
                          initialDate:
                              dateTime == null ? DateTime.now() : dateTime!,
                          firstDate: DateTime(2001),
                          lastDate: DateTime(2050))
                      .then((date) {
                    setState(() {
                      dateTime = date;
                    });
                  });
                },
              ),
              /* Padding(
                  padding: EdgeInsets.only(
                      top: minimumPadding, bottom: minimumPadding),
                  child: TextFormField(
                    style: textStyle,
                    controller: dateController,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'please the date ';
                      }
                    },
                    decoration: InputDecoration(
                        labelText: 'intervention date ',
                        hintText: 'Enter the date ',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  )),*/
              Padding(
                  padding: EdgeInsets.only(
                      top: minimumPadding, bottom: minimumPadding),
                  child: TextFormField(
                    style: textStyle,
                    controller: dureeController,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'please the necessary amount of time';
                      }
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'please the necessary amount of time',
                        hintText: 'Enter please the necessary amount of time',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  )),
              Padding(
                  padding: EdgeInsets.only(
                      top: minimumPadding, bottom: minimumPadding),
                  child: TextFormField(
                    style: textStyle,
                    controller: numeroInterventionController,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'please enter the intervention Number';
                      }
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'the intervention Number',
                        hintText: 'Enter the intervention Number',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  )),
              Padding(
                  padding: EdgeInsets.only(
                      top: minimumPadding, bottom: minimumPadding),
                  child: TextFormField(
                    style: textStyle,
                    controller: nbDeviceController,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'please enter the number of devices';
                      }
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'the number of devices',
                        hintText: 'Enter the number of devices',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  )),
              Padding(
                  padding: EdgeInsets.only(
                      top: minimumPadding, bottom: minimumPadding),
                  child: TextFormField(
                    style: textStyle,
                    controller: natureInterventionController,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'please enter the nature of the intervention';
                      }
                    },
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                        labelText: 'the nature of the intervention',
                        hintText: 'Enter the nature of the intervention',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  )),
              Padding(
                  padding: EdgeInsets.only(
                      top: minimumPadding, bottom: minimumPadding),
                  child: TextFormField(
                    style: textStyle,
                    controller: descriptionInterventionController,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'please enter the description of the intervention';
                      }
                    },
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                        labelText: 'the description of the intervention',
                        hintText: 'Enter the description of the intervention',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  )),
              Padding(
                  padding: EdgeInsets.only(
                      top: minimumPadding, bottom: minimumPadding),
                  child: TextFormField(
                    style: textStyle,
                    controller: observationController,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'please enter the Observation';
                      }
                    },
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                        labelText: 'the Observation',
                        hintText: 'Enter the Observation',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  )),
              /***********************************************************/
              SizedBox(
                height: 30,
              ),
              Center(
                child: MultiSelectDialogField<String?>(
                  items: machines!.map((list) {
                    return MultiSelectItem<String?>(list["code"].toString(),
                        list["designation"].toString());
                  }).toList(),
                  title: Text("Machines"),
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
                      selectedmachines = results;
                    });
                    machiness = [];
                    MachineModel? machine = new MachineModel();
                    await Future.forEach<String?>(selectedmachines,
                        (item) async {
                      machine = await getMachineBycode(machine, item);
                      machiness.add(machine);
                    });
                    for (var m in machiness) {
                      print(
                          m!.code.toString() + " " + m.designation.toString());
                    }
                  },
                ),
              ),
              /***********************************************************/
              /*!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!*/
              SizedBox(
                height: 30,
              ),
              Center(
                child: MultiSelectDialogField<String?>(
                  items: employees!.map((list) {
                    return MultiSelectItem<String?>(
                        list["id"].toString(),
                        list["firstName"].toString() +
                            " " +
                            list["lastName"].toString());
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
                      selectedemployees = results;
                    });
                    employess = [];
                    EmployeeModel? employee = new EmployeeModel();
                    await Future.forEach<String?>(selectedemployees,
                        (item) async {
                      employee =
                          await getEmployeebyId(employee, int.parse(item!));
                      employess.add(employee);
                    });
                  },
                ),
              ),

              /*!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!*/
              /*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
              SizedBox(
                height: 30,
              ),
              Center(
                child: MultiSelectDialogField<String?>(
                  items: pieces!.map((list) {
                    return MultiSelectItem<String?>(list["code"].toString(),
                        list["designation"].toString());
                  }).toList(),
                  title: Text("recharge parts"),
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
                      selectedpieces = results;
                    });
                    piecess = [];
                    PieceDeReChargeModel? piece = new PieceDeReChargeModel();
                    await Future.forEach<String?>(selectedpieces, (item) async {
                      piece = await getPiecebyCode(piece, item);
                      piecess.add(piece);
                    });
                  },
                ),
              ),
              /*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
              RaisedButton(
                  child: Text('Submit'),
                  onPressed: () async {
                    for (var e in employess) {
                      print(e!.firstName.toString() +
                          " " +
                          e.lastName.toString());
                    }
                    String date = DateFormat('dd-MM-yyyy').format(dateTime!);
                    int duree = int.parse(dureeController.text);
                    int numeroIntervention =
                        int.parse(numeroInterventionController.text);
                    int nbDevice = int.parse(nbDeviceController.text);
                    String natureIntervention =
                        natureInterventionController.text;
                    String descriptionIntervention =
                        descriptionInterventionController.text;
                    String observation = observationController.text;
                    InterventionModel? interventions =
                        await registerInterventions(
                            date,
                            duree,
                            numeroIntervention,
                            nbDevice,
                            natureIntervention,
                            descriptionIntervention,
                            observation,
                            client,
                            employess,
                            machiness,
                            piecess,
                            context);
                    dateController.text = '';
                    dureeController.text = '';
                    numeroInterventionController.text = '';
                    nbDeviceController.text = '';
                    natureInterventionController.text = '';
                    descriptionInterventionController.text = '';
                    descriptionInterventionController.text = '';
                    observationController.text = '';
                    machiness = [];
                    piecess = [];
                    employess = [];
                    dateTime = null;
                    setState(() {
                      intervention = interventions;
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
