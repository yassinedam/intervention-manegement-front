import 'package:employee_management/Screens/getInterventionsForIntervenant.dart';
import 'package:employee_management/Screens/loacation/GoogleMaps.dart';
import 'package:flutter/material.dart';

class employeeDrawer extends StatefulWidget {
  int? identification;
  @override
  State<StatefulWidget> createState() {
    return employeeDrawerState(identification);
  }

  employeeDrawer(this.identification);
}

class employeeDrawerState extends State<employeeDrawer> {
  int? identification;
  employeeDrawerState(this.identification);
  final minimumPadding = 5.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('intervetion Management for employee'),
      ),
      body: getInterventionsForIntervenants(identification),
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
              title: Text('Register Intervention'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            getInterventionsForIntervenants(identification)));
              },
            ),
            ListTile(
              title: Text('Google Map'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MapSample()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
