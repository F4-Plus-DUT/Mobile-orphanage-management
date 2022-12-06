// ignore_for_file: unused_local_variable, unnecessary_string_interpolations

import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:orphanage_management_system/models/statistic.dart';
import 'package:orphanage_management_system/pages/utils.dart';

class StatisticNetWork {
  static String url =
      Utility.BASE_URL + 'api/v1/statistic/donate/get_box_dashboard';
  static String donate_statistic_url = Utility.BASE_URL +
      'api/v1/statistic/donate/get_donate_statistics?start_date=2022-1-1&end_date=2022-12-1&activity_type=all';
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
    print("==========================DEBUG========================");
    print(response.statusCode);
    if (response.statusCode == 200) {
      var results = json.decode(utf8.decode(response.bodyBytes));
      List<Map<String, dynamic>> liststatistic =
          results.cast<Map<String, dynamic>>();
      data = liststatistic.map((e) => Statistic.fromJson(e)).toList();
      print(data);
      return data;
    } else if (response.statusCode == 404) {
      throw Exception('Not found');
    } else {
      throw Exception('Can not request');
    }
  }

  static Future<DonateStatistic> GetDonateStatistic() async {
    DonateStatistic data =
        new DonateStatistic(total_donate: 0, total_expense: 0);

    final response = await http.get(
      Uri.parse(donate_statistic_url),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer ' + Utility.ACCESS_TOKEN,
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Credentials': 'true',
        'Access-Control-Allow-Headers': 'Content-Type',
        'Access-Control-Allow-Methods': 'GET,PUT,POST,DELETE'
      },
    );
    print("==========================DEBUG========================");
    print(response.statusCode);
    if (response.statusCode == 200) {
      var results = json.decode(response.body);
      data = DonateStatistic.fromJson(results);
      print(data);
      return data;
    } else if (response.statusCode == 404) {
      throw Exception('Not found');
    } else {
      throw Exception('Can not request');
    }
  }
}
