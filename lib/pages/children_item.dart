// ignore_for_file: avoid_unnecessary_containers, sort_child_properties_last, unnecessary_this, must_be_immutable, use_key_in_widget_constructors, prefer_const_constructors, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:orphanage_management_system/models/children.dart';
import 'package:orphanage_management_system/network/children.dart';
import 'package:orphanage_management_system/pages/children_detail.dart';

class ChildrenItem extends StatefulWidget {
  final Children children;

  ChildrenItem({
    Key? key,
    required this.children,
  }) : super(key: key);

  @override
  State<ChildrenItem> createState() => _ChildrenItemState();
}

class _ChildrenItemState extends State<ChildrenItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // ChildrenNetWork.getDetailChildren(widget.children.id).then((value) => {
        //       Navigator.of(context).push(MaterialPageRoute(
        //           builder: (context) => ChildrenDetail(
        //                 children: value,
        //               )))
        //     });
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ChildrenDetail(
                  children: widget.children,
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
              widget.children.personal_picture ??
                  "https://t3.ftcdn.net/jpg/02/09/37/00/360_F_209370065_JLXhrc5inEmGl52SyvSPeVB23hB6IjrR.jpg  ",
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
                widget.children.name,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
              ),
              Text(
                widget.children.status,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
