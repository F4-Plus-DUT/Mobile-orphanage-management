// ignore_for_file: unused_local_variable, unnecessary_string_interpolations

import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:orphanage_management_system/models/children.dart';
import 'package:orphanage_management_system/pages/utils.dart';

class ChildrenNetWork {
  static String url =
      Utility.BASE_URL + 'api/v1/activity/adopt_request_detail';
  

  static Map<String, String> httpHeaders = {
    HttpHeaders.authorizationHeader: 'Bearer ' + Utility.ACCESS_TOKEN,
    HttpHeaders.contentTypeHeader: "multipart/form-data; charset=UTF-8",
    HttpHeaders.connectionHeader: "keep-alive",
  };

  static Future<void> RequestAdoption(int material_status, int family_status,int income) async {
    var uri = Uri.parse(url);
    var request = http.MultipartRequest('POST', uri);
    request.fields['material_status'] = material_status.toString();
    request.fields['family_status'] = family_status.toString();
    request.fields['income'] = income.toString();
    request.headers['authorization'] = 'Bearer ' + Utility.ACCESS_TOKEN;
    final streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {

    } else if (response.statusCode == 404) {
      throw Exception('Not found');
    } else {
      throw Exception('Can not request');
    }
  }
}
