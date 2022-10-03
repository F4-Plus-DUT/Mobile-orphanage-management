// ignore_for_file: avoid_unnecessary_containers, sort_child_properties_last, unnecessary_this, must_be_immutable, use_key_in_widget_constructors, prefer_const_constructors, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:orphanage_management_system/models/children.dart';

class ChildrenItem extends StatelessWidget {
  Children children;
  ChildrenItem(this.children);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.lightBlue,
      child: Container(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                children.name,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              CircleAvatar(
                backgroundImage: AssetImage(
                  children.personal_picture,
                ),
                backgroundColor: Colors.transparent,
                // radius: 20.0,
              )
            ],
          ),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}
