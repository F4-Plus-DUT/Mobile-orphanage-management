import 'package:flutter/material.dart';
import 'package:orphanage_management_system/models/children.dart';
import 'package:orphanage_management_system/network/children.dart';
import 'package:orphanage_management_system/pages/children_item.dart';

class ChildrenPage extends StatefulWidget {
  @override
  State<ChildrenPage> createState() => _ChildrenPageState();
}

class _ChildrenPageState extends State<ChildrenPage> {
  List<Children> data = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ChildrenNetWork.fetchChildren().then((value) => {
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
        title: Text('Children Listing Page'),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 16),
        child: ListView.separated(
          itemCount: data.length,
          separatorBuilder: (_, __) => Divider(),
          itemBuilder: (_, index) {
            return ChildrenItem(children: data[index]);
          },
        ),
      ),
    );
  }
}
