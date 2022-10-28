import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:orphanage_management_system/pages/activity.dart';
import 'package:orphanage_management_system/pages/children.dart';
import 'package:orphanage_management_system/pages/children_activity.dart';
import 'package:orphanage_management_system/pages/event.dart';
import 'package:orphanage_management_system/pages/home.dart';
import 'package:orphanage_management_system/pages/loading.dart';
import 'package:orphanage_management_system/pages/login.dart';
import 'package:orphanage_management_system/pages/reset_pwd.dart';
import 'package:orphanage_management_system/pages/signup.dart';
import 'package:orphanage_management_system/pages/user.dart';

//solve flutter certificate verify failed error when performing a post request
// class MyHttpOverrides extends HttpOverrides{
//   @override
//   HttpClient createHttpClient(SecurityContext? context){
//     return super.createHttpClient(context)
//       ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
//   }
// }

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  //
  // ByteData data = await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
  // SecurityContext.defaultContext.setTrustedCertificatesBytes(data.buffer.asUint8List());
  //
  // HttpOverrides.global = MyHttpOverrides();

  runApp(MaterialApp(initialRoute: '/', routes: {
    '/': (context) => Loading(),
    '/home': (context) => MyApp(),
    '/login': (context) => Login(),
    '/signup': (context) => SignUp(),
    '/reset_pwd': (context) => ResetPassword(),
    '/user': (context) => User_Page(),
    '/children': (context) => Children(),
    '/activity': (context) => ActivityPage(),
    '/events': (context) => EventPage(),
    '/children_activity': (context) => ChildrenActivityPage(),


  }));
}

