// ignore_for_file: avoid_unnecessary_containers, sort_child_properties_last, unnecessary_this, must_be_immutable, use_key_in_widget_constructors, prefer_const_constructors, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:orphanage_management_system/models/children.dart';
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
  late ValueNotifier<String> _textNotifier;

  @override
  void initState() {
    super.initState();
    _textNotifier = ValueNotifier(widget.children.name);
  }

  @override
  void dispose() {
    _textNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
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
              ValueListenableBuilder(
                valueListenable: _textNotifier,
                builder: (_, text, __) {
                  return Text(
                    text,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  );
                },
              ),
              Text(
                widget.children.status,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
              ),
              // Text(
              //   widget.children.join_date,
              //   style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
