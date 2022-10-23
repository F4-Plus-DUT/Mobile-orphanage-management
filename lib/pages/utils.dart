import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:orphanage_management_system/pages/children_page.dart';
import 'package:orphanage_management_system/pages/login.dart';
import 'package:orphanage_management_system/pages/staff_page.dart';
import 'package:orphanage_management_system/pages/user.dart';
import 'package:orphanage_management_system/pages/activity.dart';

class Utility {
  //Regex
  static RegExp hexEmail = RegExp(
      r'[a-zA-Z0-9.!#$%&*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$');
  static String BASE_URL = "https://cf5e-14-174-34-11.ap.ngrok.io/";
  static String ACCESS_TOKEN =
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjY2NjAyMTY2LCJpYXQiOjE2NjY1MTU3NjYsImp0aSI6IjI4MGEyZDQ1NGM4NzQ4MzBiNmU3MzM3ODNjNGQ2MGVjIiwidXNlcl9pZCI6IjYwNzBhODVkLWIyZWUtNDcwMS05YzllLThjZDVkODMwNmVhZiJ9.CWvbOwCYlSxZcWqN2iz6-7u1u6Pip9BEdgDSz1zc8lY';
  static String DEFAULT_AVATAR =
      "https://t3.ftcdn.net/jpg/02/09/37/00/360_F_209370065_JLXhrc5inEmGl52SyvSPeVB23hB6IjrR.jpg";
  static StatefulWidget getStatefulWidget(String name) {
    if (name == 'Account') {
      return User_Page();
    } else if (name == 'Children') {
      return ChildrenPage();
    } else if (name == 'Staff') {
      return StaffPage();
    }
    else if (name == 'Activity') {
      return ActivityPage();
    }
    else if (name == 'Statistic') {
    }
    else if (name == 'Events') {
    }
    return Login();
  }

  static String utf8convert(String text) {
    List<int> bytes = text.toString().codeUnits;
    return utf8.decode(bytes);
  }

}
