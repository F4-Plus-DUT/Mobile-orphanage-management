// ignore_for_file: unused_local_variable, unnecessary_string_interpolations

import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:orphanage_management_system/models/profile.dart';

class ProfileNetWork {
  static String ACCESS_TOKEN =
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjY1OTkwNDcyLCJpYXQiOjE2NjU5MDQwNzIsImp0aSI6IjU1MjVjNjg2ZGQyOTRjMmRhYjUyNzZjYThiNzAyNDViIiwidXNlcl9pZCI6ImU1MzM3ZjhhLThlMzYtNGJjZC1hOWVkLTQ4YjQ0MGU1Y2Q1MyJ9.ygsnkizYsf0Juq91ntBHDNtUoLFiKFhxUw9oDMj2NUY';
  static const String url =
      'https://c13b-14-236-42-223.ap.ngrok.io/api/v1/user/get_list_employee?name=';

  static List<Profile> parseProfile(String responseBody) {
    var response = json.decode(responseBody);
    var result = response["results"];
    List<Map<String, dynamic>> listprofiles =
        result.cast<Map<String, dynamic>>();
    List<Profile> profiles =
        listprofiles.map((e) => Profile.fromJson(e)).toList();
    return profiles;
  }

  static Future<List<Profile>> fetchProfile({int page = 1}) async {
    List<Profile> list = <Profile>[];
    final response = await http.get(
      Uri.parse(url),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer ' + ACCESS_TOKEN,
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Credentials': 'true',
        'Access-Control-Allow-Headers': 'Content-Type',
        'Access-Control-Allow-Methods': 'GET,PUT,POST,DELETE'
      },
    );
    if (response.statusCode == 200) {
      return compute(parseProfile, response.body);
    } else if (response.statusCode == 404) {
      throw Exception('Not found');
    } else {
      throw Exception('Can not request');
    }
  }
}
