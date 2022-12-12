import 'package:employee_management/Screens/Authontifaction.dart';
import 'package:employee_management/Screens/Loacation/DiposableMap.dart';
import 'package:employee_management/Screens/Loacation/GoogleMaps.dart';
import 'package:flutter/material.dart';

import 'Screens/adminDrawer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Employee Management',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: DisposableMapSample(),
      //home: MapSample(),
      home: adminDrawer(),
      //home: Authontifaction(),
    );
  }
}
