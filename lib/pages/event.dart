import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orphanage_management_system/pages/utils.dart';

import '../models/activity.dart';
import 'package:http/http.dart' as http;

import 'activity_detail.dart';

class EventPage extends StatefulWidget {
  @override
  State<EventPage> createState() => _EventPageState();
}

Future<List<Activity>> getAllActivities() async {
  String event_id = "8e317981-9862-4315-b4a8-daa9b8831ef2";
  List<Activity> activities = [];
  String activities_url = Utility.BASE_URL +
      "api/v1/activity?activity_type=" +
      event_id +
      "&page=1&page_size=10";
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

class _EventPageState extends State<EventPage> {
  List<Activity> activities = [];

  @override
  void initState() {
    super.initState();
    getAllActivities().then((value) => {
          setState(() {
            activities = value;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text('Events Page'),
          backgroundColor: Colors.blue,
          elevation: 0,
        ),
        body: ListView.builder(
            itemCount: activities.length,
            itemBuilder: ((context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 2.0, horizontal: 3.0),
                child: Card(
                    child: ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ActivityDetail(
                                      activity: activities[index])));
                        },
                        title: Text(
                          activities[index].title ?? "None Data",
                          style: TextStyle(fontSize: 20, color: Colors.orange),
                        ),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              activities[index].coverPicture ??
                                  Utility.DEFAULT_AVATAR),
                        ))),
              );
            })));
  }
}
