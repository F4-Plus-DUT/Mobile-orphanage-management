// ignore_for_file: unused_local_variable, unnecessary_string_interpolations

import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:orphanage_management_system/models/profile.dart';
import 'package:orphanage_management_system/pages/utils.dart';

import '../models/user.dart';

class UserNetWork {
  static String url = Utility.BASE_URL + 'api/v1/user/get_list_employee?name=';
  static String detail_url = Utility.BASE_URL + 'api/v1/user/';
  static List<User> parseUser(String responseBody) {
    var response = json.decode(responseBody);
    var result = response["results"];
    List<Map<String, dynamic>> listprofiles =
        result.cast<Map<String, dynamic>>();
    List<User> profiles = listprofiles.map((e) => User.fromJson(e)).toList();
    return profiles;
  }

  static Future<List<User>> fetchUser({int page = 1}) async {
    List<User> list = <User>[];
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
      return compute(parseUser, response.body);
    } else if (response.statusCode == 404) {
      throw Exception('Not found');
    } else {
      throw Exception('Can not request');
    }
  }

  static Future<User> getDetailStaff(String id) async {
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
      User result = User.fromJson(responses);
      return result;
    } else if (response.statusCode == 404) {
      throw Exception('Not found');
    } else {
      throw Exception('Can not request');
    }
  }

  static Future<User> UpdateUserInfo(User user) async {
    String c_url = detail_url + (user.id ?? "");
    var uri = Uri.parse(c_url);
    var request = http.MultipartRequest('PUT', uri);
    request.fields['name'] = user.name!;
    request.fields['email'] = user.email!;
    request.fields['address'] = user.address!;
    request.fields['phone'] = user.phone!;
    request.fields['occupation'] = user.occupation!;
    request.headers['authorization'] = 'Bearer ' + Utility.ACCESS_TOKEN;
    final streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      var responses = json.decode(response.body);
      User result = User.fromJson(responses);
      return result;
    } else if (response.statusCode == 404) {
      throw Exception('Not found');
    } else {
      throw Exception('Can not request');
    }
  }

  static Future<User> UpdateUserAvatar(String id, String avatar) async {
    String c_url = detail_url + id;
    var uri = Uri.parse(c_url);
    print("==============DEBUG===============");
    var request = http.MultipartRequest('PUT', uri);
    request.files.add(await http.MultipartFile.fromPath('avatar', avatar));
    request.headers['authorization'] = 'Bearer ' + Utility.ACCESS_TOKEN;
    final streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      var responses = json.decode(response.body);
      User result = User.fromJson(responses);
      return result;
    } else if (response.statusCode == 404) {
      throw Exception('Not found');
    } else {
      throw Exception('Can not request');
    }
  }
}
