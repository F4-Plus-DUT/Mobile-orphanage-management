// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:orphanage_management_system/models/profile.dart';
import 'package:orphanage_management_system/network/profile.dart';
import 'package:orphanage_management_system/pages/staff_item.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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

  late List<Profile> ProfileList = [
    Profile(
        id: "0eef8b2e-c9bb-46e1-af95-cd75a1ce3ecf",
        created_at: "2022-10-01T15:46:18.352835+07:00",
        updated_at: "2022-10-01T15:46:18.354779+07:00",
        address: "Hue",
        name: "Lalisa",
        email: "contact.haha@gmail.com",
        age: 8,
        avatar:
            "https://anhdephd.vn/wp-content/uploads/2022/04/hinh-anh-one-piece-chibi-ngay-ngo.jpg",
        occupation: "Staff",
        phone: "0375938780"),
    Profile(
        id: "0eef8b2e-c9bb-46e1-af95-cd75a1ce3ecf",
        created_at: "2022-10-01T15:46:18.352835+07:00",
        updated_at: "2022-10-01T15:46:18.354779+07:00",
        address: "Hue",
        name: "Lalisa",
        email: "contact.haha@gmail.com",
        age: 8,
        avatar:
            "https://img4.thuthuatphanmem.vn/uploads/2020/12/26/hinh-nen-one-piece-chibi-cute_120602855.jpg",
        occupation: "Staff",
        phone: "0375938780"),
    Profile(
        id: "0eef8b2e-c9bb-46e1-af95-cd75a1ce3ecf",
        created_at: "2022-10-01T15:46:18.352835+07:00",
        updated_at: "2022-10-01T15:46:18.354779+07:00",
        address: "Hue",
        name: "Lalisa",
        email: "contact.haha@gmail.com",
        age: 8,
        avatar:
            "https://res.cloudinary.com/boninguci/image/upload/v1664611125/pbl6/children/1_phajxg.jpg",
        occupation: "Staff",
        phone: "0375938780"),
    Profile(
        id: "0eef8b2e-c9bb-46e1-af95-cd75a1ce3ecf",
        created_at: "2022-10-01T15:46:18.352835+07:00",
        updated_at: "2022-10-01T15:46:18.354779+07:00",
        address: "Hue",
        name: "Lalisa",
        email: "contact.haha@gmail.com",
        age: 8,
        avatar:
            "https://res.cloudinary.com/boninguci/image/upload/v1664611125/pbl6/children/1_phajxg.jpg",
        occupation: "Staff",
        phone: "0375938780")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Staff Listing Page'),
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
