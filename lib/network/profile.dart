// ignore_for_file: unused_local_variable, unnecessary_string_interpolations

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:orphanage_management_system/models/profile.dart';

class ProfileNetWork {
  static const String url = '';

  static List<Profile> parseProfile(String responseBody) {
    var list = json.decode(responseBody) as List<dynamic>;
    List<Profile> profiles = list.map((e) => Profile.fromJson(e)).toList();
    return profiles;
  }

  static Future<List<Profile>> fetchProfile({int page = 1}) async {
    List<Profile> list = <Profile>[];
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return compute(parseProfile, response.body);
    } else if (response.statusCode == 404) {
      throw Exception('Not found');
    } else {
      throw Exception('Can not request');
    }
  }
}
