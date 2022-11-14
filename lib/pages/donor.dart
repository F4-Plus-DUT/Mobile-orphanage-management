import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:orphanage_management_system/helper/convert.dart';
import "package:orphanage_management_system/helper/string_helper.dart";
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:orphanage_management_system/models/donor.dart';
import 'package:orphanage_management_system/pages/utils.dart';

class DonorPage extends StatefulWidget {
  String activity_id;

  DonorPage({super.key, required this.activity_id});
  @override
  State<DonorPage> createState() => _DonorPageState();
}

Future<List<Donor>> getAllDonors(String activity_id) async {
  List<Donor> donors = [];
  print("=================ACTIVITY================");
  print(activity_id);
  String donors_url =
      Utility.BASE_URL + "api/v1/statistic/donate?activity=" + activity_id;
  print(donors_url);
  final response = await http.get(
    Uri.parse(donors_url),
    headers: {
      HttpHeaders.authorizationHeader: 'Bearer ' + Utility.ACCESS_TOKEN,
      HttpHeaders.acceptEncodingHeader: 'gzip, deflate, br',
      HttpHeaders.acceptHeader: '*/*'
    },
  );
  print(utf8.decode(response.bodyBytes));
  // print(utf8.decode(utf8.encode(response.body)));
  var body = json.decode(utf8.decode(response.bodyBytes));
  var results = body['results'];
  print(results);
  List<Map<String, dynamic>> listDonor = results.cast<Map<String, dynamic>>();
  donors = listDonor.map((e) => Donor.fromJson(e)).toList();
  return donors;
}

class _DonorPageState extends State<DonorPage> {
  List<Donor> donors = [];
  @override
  void initState() {
    super.initState();
    getAllDonors(widget.activity_id).then((value) => {
          setState(() {
            donors = value;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text('Donor Page'),
          backgroundColor: Colors.blue,
          elevation: 0,
        ),
        body: ListView.builder(
            itemCount: donors.length,
            itemBuilder: ((context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 2.0, horizontal: 3.0),
                child: Card(
                    child: ListTile(
                  onTap: () {},
                  title: Text(
                    donors[index].donor?.toTitleCase() ?? "None Data",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontFamily: "Times New Roman"),
                  ),
                  subtitle: Text(
                    donors[index].note?.capitalize() ?? " - ",
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  trailing: Text(
                    current_donate(donors[index].amount ?? 0),
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                )),
              );
            })));
  }
}
