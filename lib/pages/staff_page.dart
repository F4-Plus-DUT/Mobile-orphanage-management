// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:orphanage_management_system/models/profile.dart';
import 'package:orphanage_management_system/network/profile.dart';
import 'package:orphanage_management_system/pages/staff_item.dart';

class StaffPage extends StatefulWidget {
  @override
  State<StaffPage> createState() => _StaffPageState();
}

class _StaffPageState extends State<StaffPage> {
  List<Profile> data = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ProfileNetWork.fetchProfile().then((value) => {
          setState(
            () {
              data = value;
            },
          )
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Staff Page'),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 16),
        child: ListView.separated(
          itemCount: data.length,
          separatorBuilder: (_, __) => Divider(),
          itemBuilder: (_, index) {
            return StaffItem(profile: data[index]);
          },
        ),
      ),
    );
  }
}
