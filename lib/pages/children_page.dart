// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:orphanage_management_system/models/children.dart';
import 'package:orphanage_management_system/pages/children_item.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ChildrenPage extends StatefulWidget {
  @override
  State<ChildrenPage> createState() => _ChildrenPageState();
}

class _ChildrenPageState extends State<ChildrenPage> {
  late List<Children> children = [
    Children(
        id: "0eef8b2e-c9bb-46e1-af95-cd75a1ce3ecf",
        created_at: "2022-10-01T15:46:18.352835+07:00",
        updated_at: "2022-10-01T15:46:18.354779+07:00",
        is_active: true,
        name: "Lalisa",
        gender: 2,
        age: 8,
        personal_picture:
            "https://res.cloudinary.com/boninguci/image/upload/v1664611125/pbl6/children/1_phajxg.jpg",
        join_date: "2022-10-01T07:00:00+07:00",
        status: "Unadopted"),
    Children(
        id: "0eef8b2e-c9bb-46e1-af95-cd75a1ce3ecf",
        created_at: "2022-10-01T15:46:18.352835+07:00",
        updated_at: "2022-10-01T15:46:18.354779+07:00",
        is_active: true,
        name: "Lalisa",
        gender: 2,
        age: 8,
        personal_picture:
            "https://res.cloudinary.com/boninguci/image/upload/v1664611125/pbl6/children/1_phajxg.jpg",
        join_date: "2022-10-01T07:00:00+07:00",
        status: "Unadopted"),
    Children(
        id: "0eef8b2e-c9bb-46e1-af95-cd75a1ce3ecf",
        created_at: "2022-10-01T15:46:18.352835+07:00",
        updated_at: "2022-10-01T15:46:18.354779+07:00",
        is_active: true,
        name: "Lalisa",
        gender: 2,
        age: 8,
        personal_picture:
            "https://res.cloudinary.com/boninguci/image/upload/v1664611125/pbl6/children/1_phajxg.jpg",
        join_date: "2022-10-01T07:00:00+07:00",
        status: "Unadopted"),
    Children(
        id: "0eef8b2e-c9bb-46e1-af95-cd75a1ce3ecf",
        created_at: "2022-10-01T15:46:18.352835+07:00",
        updated_at: "2022-10-01T15:46:18.354779+07:00",
        is_active: true,
        name: "Lalisa",
        gender: 2,
        age: 8,
        personal_picture:
            "https://res.cloudinary.com/boninguci/image/upload/v1664611125/pbl6/children/1_phajxg.jpg",
        join_date: "2022-10-01T07:00:00+07:00",
        status: "Unadopted")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView(
        padding: EdgeInsets.all(12),
        children: children
            .map((eachCategories) => ChildrenItem(eachCategories))
            .toList(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 300,
            childAspectRatio: 7 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
      ),
    );
  }
}
