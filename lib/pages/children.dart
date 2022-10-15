import 'package:flutter/material.dart';
import 'package:orphanage_management_system/models/Category.dart';
import 'package:orphanage_management_system/services/CategoryService.dart';

class Children extends StatefulWidget {
  @override
  State<Children> createState() => _ChildrenState();
}

class _ChildrenState extends State<Children> {
  List<Category> categories = CategoryService.getAllCategories();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Children Page"),
    );
  }
}
