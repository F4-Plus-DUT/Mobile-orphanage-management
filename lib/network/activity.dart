import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/activity.dart';
import '../pages/utils.dart';

class ActivityNetwork {
  static Future<List<Activity>> getAllActivities() async {
    List<Activity> activities = [];
    String activities_url = Utility.BASE_URL +
        "api/v1/activity?activity_type=all&page=1&page_size=10";
    final response = await http.get(
      Uri.parse(activities_url),
    );
    var body = json.decode(response.body);
    var results = body['results'];
    List<Map<String, dynamic>> listActivity =
        results.cast<Map<String, dynamic>>();
    activities = listActivity.map((e) => Activity.fromJson(e)).toList();
    return activities;
  }

  static Future<Activity> getActivity(String id) async {
    String activities_url = Utility.BASE_URL + "api/v1/activity/" + id;
    final response = await http.get(
      Uri.parse(activities_url),
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
      Activity result = Activity.fromJson(responses);
      return result;
    } else if (response.statusCode == 404) {
      throw Exception('Not found');
    } else {
      throw Exception('Can not request');
    }
  }
}
