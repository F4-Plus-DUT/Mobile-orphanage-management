import 'package:flutter/material.dart';
import 'package:orphanage_management_system/pages/login.dart';
import 'package:orphanage_management_system/pages/user.dart';

import 'children.dart';

class Utility {
  static String BASE_URL = "https://b6c8-116-105-172-59.ap.ngrok.io/";
  static StatefulWidget getStatefulWidget(String name){
    if (name == 'Account'){
      return User();
    }
    else if (name == 'Children'){
      return Children();
    }
    return Login();
  }
}