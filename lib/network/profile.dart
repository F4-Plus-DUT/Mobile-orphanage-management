// ignore_for_file: unused_local_variable, unnecessary_string_interpolations

import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:orphanage_management_system/models/profile.dart';
import 'package:orphanage_management_system/pages/utils.dart';

class ProfileNetWork {
  static String url = Utility.BASE_URL + 'api/v1/user/get_list_employee?name=';
  static String detail_url = Utility.BASE_URL + 'api/v1/user/';
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
        HttpHeaders.authorizationHeader: 'Bearer ' + Utility.ACCESS_TOKEN,
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

  static Future<Profile> getDetailStaff(String id) async {
    String c_url = detail_url + id;
    final response = await http.get(
      Uri.parse(c_url),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer ' + Utility.ACCESS_TOKEN,
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Credentials': 'true',
        'Access-Control-Allow-Headers': 'Content-Type',
        'Access-Control-Allow-Methods': 'GET,PUT,POST,DELETE'
      },
    );
    if (response.statusCode == 200) {
      var responses = json.decode(response.body);
      Profile result = Profile.fromJson(responses);
      return result;
    } else if (response.statusCode == 404) {
      throw Exception('Not found');
    } else {
      throw Exception('Can not request');
    }
  }

  static Future<Profile> UpdateProfileInfo(Profile staff) async {
    String c_url = detail_url + staff.id;
    print("===============DEBUG============");
    print(staff.toJson());
    final response = await http.post(
      Uri.parse(c_url),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer ' + Utility.ACCESS_TOKEN,
      },
      body: staff.toJson(),
    );
    print("===============DEBUG============");
    print(response.statusCode);
    if (response.statusCode == 200) {
      var responses = json.decode(response.body);
      Profile result = Profile.fromJson(responses);
      return result;
    } else if (response.statusCode == 404) {
      throw Exception('Not found');
    } else {
      throw Exception('Can not request');
    }
  }
}
