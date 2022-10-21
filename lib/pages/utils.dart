import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:orphanage_management_system/pages/children_page.dart';
import 'package:orphanage_management_system/pages/login.dart';
import 'package:orphanage_management_system/pages/staff_page.dart';
import 'package:orphanage_management_system/pages/user.dart';

class Utility {
  static String BASE_URL = "https://orphanage-management-web-app.azurewebsites.net/";
  static String ACCESS_TOKEN =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjY2MjY2NDcwLCJpYXQiOjE2NjYxODAwNzAsImp0aSI6IjBlYjdkM2VmOTczODQ1NzZhNzIzYjYwN2Q3YzY3NGYyIiwidXNlcl9pZCI6IjYwNzBhODVkLWIyZWUtNDcwMS05YzllLThjZDVkODMwNmVhZiJ9.jWcRqyEq2RTRyC-3_qRACjYgma2TSHIwvh60xMUbVDU';
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
    return Login();
  }

  static String utf8convert(String text) {
    List<int> bytes = text.toString().codeUnits;
    return utf8.decode(bytes);
  }
}
