// ignore_for_file: avoid_unnecessary_containers, sort_child_properties_last, unnecessary_this, must_be_immutable, use_key_in_widget_constructors, prefer_const_constructors, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:orphanage_management_system/models/profile.dart';
import 'package:orphanage_management_system/pages/staff_detail.dart';

class StaffItem extends StatefulWidget {
  final Profile profile;

  StaffItem({
    Key? key,
    required this.profile,
  }) : super(key: key);

  @override
  State<StaffItem> createState() => _StaffItemState();
}

class _StaffItemState extends State<StaffItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => StaffDetail(
                  profile: widget.profile,
                )));
      },
      highlightColor: (Colors.black26),
      splashColor: Colors.lightBlue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(99),
            child: Image.network(
              widget.profile.avatar ??
                  "https://img4.thuthuatphanmem.vn/uploads/2020/12/26/hinh-nen-one-piece-chibi-cute_120602855.jpg",
              width: 70,
              height: 70,
              fit: BoxFit.cover,
            ),
            // radius: 20.0,
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.profile.name,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
              ),
              Text(
                widget.profile.email,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
