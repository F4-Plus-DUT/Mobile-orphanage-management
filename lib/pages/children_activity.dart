import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orphanage_management_system/pages/utils.dart';
import 'package:http/http.dart' as http;
import '../models/activity.dart';
import 'activity_detail.dart';

class ChildrenActivityPage extends StatefulWidget {
  @override
  State<ChildrenActivityPage> createState() => _ChildrenActivityPageState();
}

Future<List<Activity>> getAllActivities() async {
  String children_page_id = "7cf19074-71bd-45b1-9d64-693d663bd22f";
  List<Activity> activities = [];
  String activities_url = Utility.BASE_URL +
      "api/v1/activity?activity_type=" +
      children_page_id +
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

class _ChildrenActivityPageState extends State<ChildrenActivityPage> {
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
          title: Text('Children Activity Page'),
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
