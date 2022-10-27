import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:orphanage_management_system/pages/children_page.dart';
import 'package:orphanage_management_system/pages/login.dart';
import 'package:orphanage_management_system/pages/staff_page.dart';
import 'package:orphanage_management_system/pages/user.dart';
import 'package:orphanage_management_system/pages/activity.dart';

class Utility {
  static String BASE_URL = "https://orphanage-management.herokuapp.com/";
  static String ACCESS_TOKEN =
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjY1OTg4MzQwLCJpYXQiOjE2NjU5MDE5NDAsImp0aSI6Ijk4NWJlYzUxYzIxNzRjMmFiYjc1YThjYzZiYjczNTQ5IiwidXNlcl9pZCI6IjYwNzBhODVkLWIyZWUtNDcwMS05YzllLThjZDVkODMwNmVhZiJ9.12E-dbX-DOyWs6VZ-_c1ZDoNQQnMC42qERa9v1pZyaE';
  static String DEFAULT_AVATAR =
      "https://t3.ftcdn.net/jpg/02/09/37/00/360_F_209370065_JLXhrc5inEmGl52SyvSPeVB23hB6IjrR.jpg";
  static String USER_EMAIL = "";
  static RegExp hexEmail = RegExp(
      r'[a-zA-Z0-9.!#$%&*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$');

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
