import 'package:flutter/material.dart';
import 'package:orphanage_management_system/pages/children.dart';
import 'package:orphanage_management_system/pages/home.dart';
import 'package:orphanage_management_system/pages/login.dart';
import 'package:orphanage_management_system/pages/reset_pwd.dart';
import 'package:orphanage_management_system/pages/signup.dart';
import 'package:orphanage_management_system/pages/user.dart';

void main() {
  runApp(MaterialApp(initialRoute: '/', routes: {
    '/': (context) => Home(),
    '/home': (context) => MyApp(),
    '/login': (context) => Login(),
    '/signup': (context) => SignUp(),
    '/reset_pwd': (context) => ResetPassword(),
    '/user': (context) => User_Page(),
    '/children': (context) => Children(),
  }));
}
