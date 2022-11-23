import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:orphanage_management_system/pages/children_page.dart';
import 'package:orphanage_management_system/pages/login.dart';
import 'package:orphanage_management_system/pages/staff_page.dart';
import 'package:orphanage_management_system/pages/statistic.dart';
import 'package:orphanage_management_system/pages/user.dart';
import 'package:orphanage_management_system/pages/activity.dart';

import '../models/profile.dart';
import '../models/user.dart';
import 'children_activity.dart';
import 'event.dart';

class Utility {
  static String BASE_URL = "https://orphanage-management.herokuapp.com/";
  static String ACCESS_TOKEN = "";
  static String DEFAULT_AVATAR =
      "https://t3.ftcdn.net/jpg/02/09/37/00/360_F_209370065_JLXhrc5inEmGl52SyvSPeVB23hB6IjrR.jpg";
  static RegExp hexEmail = RegExp(
      r'[a-zA-Z0-9.!#$%&*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$');
  static User CURRENT_PROFILE = User(roles: new Roles(levels: 4));
  static StatefulWidget getStatefulWidget(String name) {
    if (name == 'Account') {
      return User_Page();
    } else if (name == 'Children') {
      return ChildrenPage();
    } else if (name == 'Staff') {
      return StaffPage();
    } else if (name == 'Activity') {
      return ActivityPage();
    } else if (name == 'Event') {
      return EventPage();
    } else if (name == 'Adoption and Introduction') {
      return ChildrenActivityPage();
    } else if (name == 'Statistic') {
      return StatisticPage();
    }
    return Login();
  }

  static String utf8convert(String text) {
    List<int> bytes = text.toString().codeUnits;
    return utf8.decode(bytes);
  }
}
