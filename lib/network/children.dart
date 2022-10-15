// ignore_for_file: unused_local_variable, unnecessary_string_interpolations

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:orphanage_management_system/models/children.dart';

class ChildrenNetWork {
  static const String url = '';

  static List<Children> parseChildren(String responseBody) {
    var list = json.decode(responseBody) as List<dynamic>;
    List<Children> childrens = list.map((e) => Children.fromJson(e)).toList();
    return childrens;
  }

  static Future<List<Children>> fetchChildren({int page = 1}) async {
    List<Children> list = <Children>[];
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return compute(parseChildren, response.body);
    } else if (response.statusCode == 404) {
      throw Exception('Not found');
    } else {
      throw Exception('Can not request');
    }
  }
}
