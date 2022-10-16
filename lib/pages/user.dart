import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:orphanage_management_system/models/user.dart';
import 'package:orphanage_management_system/pages/user_detail.dart';
import 'package:orphanage_management_system/pages/utils.dart';

class User_Page extends StatefulWidget {
  @override
  State<User_Page> createState() => _User_PageState();
}

Future<List<User>> getAllUsers() async {
  List<User> users = [];
  String user_url = Utility.BASE_URL + "api/v1/user";
  final response = await http.get(
    Uri.parse(user_url),
    headers: {
      HttpHeaders.authorizationHeader: 'Bearer ' + Utility.ACCESS_TOKEN,
    },
  );
  var body = json.decode(response.body);
  var results = body['results'];
  List<Map<String, dynamic>> listUser = results.cast<Map<String, dynamic>>();
  users = listUser.map((e) => User.fromJson(e)).toList();
  return users;
}

class _User_PageState extends State<User_Page> {
  List<User> users = [];

  @override
  void initState() {
    super.initState();
    getAllUsers().then((value) => {
          setState(() {
            users = value;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('User Page'),
          backgroundColor: Colors.blue,
          elevation: 0,
        ),
        body: ListView.builder(
            itemCount: users.length,
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
                                  builder: (context) =>
                                      UsertDetail(user: users[index])));
                        },
                        title: Text(
                          users[index].name ?? "None Data",
                          style: TextStyle(fontSize: 20, color: Colors.orange),
                        ),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              users[index].avatar ?? Utility.DEFAULT_AVATAR),
                        ))),
              );
            })));
  }
}
