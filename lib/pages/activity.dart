import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:orphanage_management_system/pages/utils.dart';

import '../models/activity.dart';
import '../network/activity.dart';
import 'activity_detail.dart';

class ActivityPage extends StatefulWidget {
  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  List<Activity> activities = [];

  @override
  void initState() {
    print("===========================DEBUG==========================");
    print(Utility.CURRENT_PROFILE);
    super.initState();
    ActivityNetwork.getAllActivities().then((value) => {
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
          title: Text('Activity Page'),
          backgroundColor: Colors.blue,
          elevation: 0,
        ),
        body: FutureBuilder<List<Activity>>(
            future: ActivityNetwork.getAllActivities(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              activities = snapshot.data!;
              return ListView.builder(
                  itemCount: activities.length,
                  itemBuilder: ((context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2.0, horizontal: 3.0),
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
                                style: TextStyle(
                                    fontSize: 20, color: Colors.orange),
                              ),
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    activities[index].coverPicture ??
                                        Utility.DEFAULT_AVATAR),
                              ))),
                    );
                  }));
            }));
  }
}
