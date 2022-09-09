import 'package:flutter/material.dart';
import 'package:orphanage_management_system/pages/home.dart';
import 'package:orphanage_management_system/pages/loading.dart';
import 'package:orphanage_management_system/pages/login.dart';
import 'package:orphanage_management_system/pages/signup.dart';

void main() {
  runApp(MaterialApp(initialRoute: '/', routes: {
    '/': (context) => Loading(),
    '/home': (context) => Home(),
    '/login': (context) => Login(),
    '/signup': (context) => SignUp(),
  }));
}
