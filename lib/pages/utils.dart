import 'package:flutter/material.dart';
import 'package:orphanage_management_system/pages/children_page.dart';
import 'package:orphanage_management_system/pages/login.dart';
import 'package:orphanage_management_system/pages/staff_page.dart';
import 'package:orphanage_management_system/pages/user.dart';

class Utility {
  static String BASE_URL = "https://3f10-113-185-53-132.ap.ngrok.io/";
  static StatefulWidget getStatefulWidget(String name){
    if (name == 'Account'){
      return User();
    } else if (name == 'Children') {
      return ChildrenPage();
    } else if (name == 'Staff') {
      return StaffPage();
    }
    return Login();
  }
}
