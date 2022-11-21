import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:orphanage_management_system/pages/donate.dart';
import 'package:orphanage_management_system/pages/donor.dart';
import 'package:orphanage_management_system/pages/utils.dart';
import '../models/activity.dart';
import 'package:flutter_html/flutter_html.dart';
import 'comment.dart';
import 'package:orphanage_management_system/helper/convert.dart';

class ActivityDetail extends StatefulWidget {
  final Activity activity;

  const ActivityDetail({super.key, required this.activity});
  @override
  State<StatefulWidget> createState() => _ActivityDetailState();
}

Future<Activity> getActivity(String id) async {
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

class _ActivityDetailState extends State<ActivityDetail> {
  // late Activity data = new Activity();
  @override
  void initState() {
    // getActivity(widget.activity.id ?? "").then((value) => {
    //       setState(() {
    //         data = value;
    //       })
    //     });

    super.initState();
  }

  bool isLike = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Activity Detail Page"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
            child: FutureBuilder<Activity>(
                future: getActivity(widget.activity.id ?? ""),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final data = snapshot.data;
                  return Column(
                    children: [
                      Center(
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  border: Border.all(color: Colors.white)),
                              child: ClipRRect(
                                // borderRadius: BorderRadius.circular(99),
                                child: Image.network(
                                  data?.coverPicture ?? Utility.DEFAULT_AVATAR,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Center(
                          child: SingleChildScrollView(
                        child: Html(
                          data: """ ${data?.content} <hr> """,
                          defaultTextStyle: TextStyle(
                            fontSize: 14.0,
                          ),
                          padding: EdgeInsets.all(5.0),
                          onLinkTap: (url) {},
                          backgroundColor: Colors.white70,
                        ),
                      )),
                      Text(
                        "Estimated cost: " +
                            current_donate(data?.expense?.toInt() ?? 0) +
                            "  VND",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: (() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DonorPage(activity_id: data?.id ?? "")));
                        }),
                        child: Text(
                          "Current donate: " +
                              current_donate(data?.donate ?? 0) +
                              "  VND",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                              padding: EdgeInsets.only(top: 40.0, left: 20.0)),
                          GestureDetector(
                            onTap: () => {},
                            child: Icon(
                                isLike ? Icons.favorite : Icons.favorite_border,
                                size: 28.0,
                                color: Colors.pink),
                          ),
                          Padding(padding: EdgeInsets.only(right: 20.0)),
                          GestureDetector(
                            onTap: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CommentPage(
                                          activity_id: data?.id ?? "")))
                            },
                            child: Icon(Icons.chat,
                                size: 28.0, color: Colors.blue[900]),
                          ),
                          Padding(padding: EdgeInsets.only(right: 20.0)),
                          GestureDetector(
                            onTap: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DonatePage(
                                            current_user:
                                                Utility.CURRENT_PROFILE,
                                            activity: data,
                                          )))
                            },
                            child: Text(
                              "Donate",
                              style: TextStyle(
                                  fontSize: 28, color: Colors.blueAccent),
                            ),
                          ),
                        ],
                      )
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }
}
