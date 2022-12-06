// ignore_for_file: unused_local_variable, unnecessary_string_interpolations

import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:orphanage_management_system/models/children.dart';
import 'package:orphanage_management_system/pages/utils.dart';

class DonateNetWork {
  static String url = Utility.BASE_URL + 'api/v1/statistic/donate';

  static Map<String, String> httpHeaders = {
    HttpHeaders.authorizationHeader: 'Bearer ' + Utility.ACCESS_TOKEN,
    HttpHeaders.contentTypeHeader: "application/json; charset=UTF-8",
    HttpHeaders.connectionHeader: "keep-alive",
  };

  static Future<int> Donate(
      String email, String activity_id, int amount, String note) async {
    late int a;
    await http
        .post(Uri.parse(url),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              HttpHeaders.authorizationHeader: 'Bearer ' + Utility.ACCESS_TOKEN,
            },
            body: jsonEncode(<String, dynamic>{
              'email': email,
              'activity': activity_id,
              'amount': amount / 1000,
              'note': note
            }))
        .then((response) {
      print(response.statusCode);
      a = response.statusCode;
      if (response.statusCode == 201) {
        print("============DONE=============");
        print(Utility.ACCESS_TOKEN);
        print(response.body);
        a = 201;
      }
    });

    return a;
  }
}
