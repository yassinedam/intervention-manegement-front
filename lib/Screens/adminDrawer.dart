import 'package:employee_management/Screens/Authontifaction.dart';
import 'package:employee_management/Screens/Client/getClients.dart';
import 'package:employee_management/Screens/Company/getCompanies.dart';
import 'package:employee_management/Screens/Intervention/getIntervention.dart';
import 'package:employee_management/Screens/User/registerUser.dart';
import 'package:employee_management/Screens/Machine/getMachines.dart';
import 'package:employee_management/Screens/PieceDeRecharge/getPieces.dart';
import 'package:employee_management/Screens/Client/registerClient.dart';
import 'package:employee_management/Screens/Company/registerCompany.dart';
import 'package:employee_management/Screens/Intervention/registerIntervention.dart';
import 'package:employee_management/Screens/Employee/registerEmployee.dart';
import 'package:employee_management/Screens/Machine/registerMachine.dart';
import 'package:employee_management/Screens/Employee/getEmployees.dart';
import 'package:employee_management/Screens/PieceDeRecharge/registerPieceDeRecharge.dart';
import 'package:flutter/material.dart';

class adminDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return adminDrawerState();
  }
}

class adminDrawerState extends State<adminDrawer> {
  final minimumPadding = 5.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Itervention Management '),
      ),
      body: getInterventions(),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.only(top: minimumPadding, bottom: minimumPadding),
          children: <Widget>[
            DrawerHeader(
              child: Text('Employee Management'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Get Employees'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => getemployees()));
              },
            ),
            /* ListTile(
              title: Text('register intervention for new client'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => registerCompany()));
              },
            ),
            ListTile(
              title: Text('register intervention for old client'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => registerIntervention()));
              },
            ),*/
            ListTile(
              title: Text('Get Company'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => getCompanies()));
              },
            ),
            ListTile(
              title: Text('Get Clients'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => getClients()));
              },
            ),
            ListTile(
              title: Text('get Machine'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => getMachines()));
              },
            ),
            ListTile(
              title: Text('get Piece'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => getPieces()));
              },
            ),
            ListTile(
              title: Text('register User'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => registerUser()));
              },
            ),
            ListTile(
              title: Text('Authontifaction'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Authontifaction()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
