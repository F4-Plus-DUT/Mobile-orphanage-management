// ignore_for_file: unused_local_variable, unnecessary_string_interpolations

import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:orphanage_management_system/models/statistic.dart';
import 'package:orphanage_management_system/pages/utils.dart';

class DonateNetWork {
  static String url = Utility.BASE_URL + 'api/v1/statistic/donate/get_box_dashboard';

  static Map<String, String> httpHeaders = {
    HttpHeaders.authorizationHeader: 'Bearer ' + Utility.ACCESS_TOKEN,
    HttpHeaders.contentTypeHeader: "application/json; charset=UTF-8",
    HttpHeaders.connectionHeader: "keep-alive",
  };

  static Future<List<Statistic>> GetStatistic() async {
    List<Statistic> data = <Statistic>[];
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
      var body = json.decode(utf8.decode(response.bodyBytes));
      var results = body['results'];
      List<Map<String, dynamic>> liststatistic =
          results.cast<Map<String, dynamic>>();
      data = liststatistic.map((e) => Statistic.fromJson(e)).toList();
      return data;
    } else if (response.statusCode == 404) {
      throw Exception('Not found');
    } else {
      throw Exception('Can not request');
    }
  }
}
