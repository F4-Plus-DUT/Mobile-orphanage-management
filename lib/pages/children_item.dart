// ignore_for_file: avoid_unnecessary_containers, sort_child_properties_last, unnecessary_this, must_be_immutable, use_key_in_widget_constructors, prefer_const_constructors, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:orphanage_management_system/models/children.dart';

class ChildrenItem extends StatefulWidget {
  Children children;

  ChildrenItem(this.children);

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
      },
      highlightColor: (Colors.black26),
      splashColor: Colors.lightBlue,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: 100,
              child: CircleAvatar(
                child: Image.network(
                  widget.children.personal_picture,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
                backgroundColor: Colors.transparent,

                // radius: 20.0,
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ValueListenableBuilder(
                    valueListenable: _textNotifier,
                    builder: (_, text, __) {
                      return Text(
                        text,
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      );
                    },
                  ),
                  Text(
                    widget.children.status,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.children.join_date,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
