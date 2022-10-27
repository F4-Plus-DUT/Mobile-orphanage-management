// ignore_for_file: unused_local_variable, unnecessary_string_interpolations

import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:orphanage_management_system/models/children.dart';
import 'package:orphanage_management_system/pages/utils.dart';

class ChildrenNetWork {
  static String url =
      Utility.BASE_URL + 'api/v1/children?name=&age=&gender=&status=';
  static String detail_url = Utility.BASE_URL + 'api/v1/children/';
  static List<Children> parseChildren(String responseBody) {
    var response = json.decode(responseBody);
    var result = response["results"];
    List<Map<String, dynamic>> listchildren =
        result.cast<Map<String, dynamic>>();
    List<Children> children =
        listchildren.map((e) => Children.fromJson(e)).toList();
    return children;
  }

  static Future<List<Children>> fetchChildren(
      {int page = 1, int page_size = 4}) async {
    List<Children> list = <Children>[];
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
      return compute(parseChildren, response.body);
    } else if (response.statusCode == 404) {
      throw Exception('Not found');
    } else {
      throw Exception('Can not request');
    }
  }

  static Future<Children> getDetailChildren(String id) async {
    String c_url = detail_url + id;
    final response = await http.get(
      Uri.parse(c_url),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer ' + Utility.ACCESS_TOKEN,
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Credentials': 'true',
        'Access-Control-Allow-Headers': 'Content-Type',
        'Access-Control-Allow-Methods': 'GET,PUT,POST,DELETE'
      },
    );
    if (response.statusCode == 200) {
      var responses = json.decode(response.body);
      Children result = Children.fromJson(responses);
      return result;
    } else if (response.statusCode == 404) {
      throw Exception('Not found');
    } else {
      throw Exception('Can not request');
    }
  }

  static Future<Children> UpdateChildrenInfo(Children children) async {
    String c_url = detail_url + children.id;
    print("===============DEBUG============");
    print(c_url);
    print(children.toJson());
    final response = await http.post(
      Uri.parse(c_url),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer ' + Utility.ACCESS_TOKEN,
      },
      body: children.toJson(),
    );
    print("===============DEBUG============");
    print(response.statusCode);
    if (response.statusCode == 200) {
      var responses = json.decode(response.body);
      Children result = Children.fromJson(responses);
      return result;
    } else if (response.statusCode == 404) {
      throw Exception('Not found');
    } else {
      throw Exception('Can not request');
    }
  }
}
