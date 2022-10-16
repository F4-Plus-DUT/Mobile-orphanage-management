import 'package:flutter/material.dart';
import 'package:orphanage_management_system/models/category.dart';

import '../services/category_service.dart';

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
