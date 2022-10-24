import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:orphanage_management_system/models/children.dart';
import 'package:orphanage_management_system/pages/edit_children_info.dart';

class ChildrenDetail extends StatefulWidget {
  final Children children;

  const ChildrenDetail({super.key, required this.children});
  @override
  State<StatefulWidget> createState() => _ChildrenDetailState();
}

class _ChildrenDetailState extends State<ChildrenDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Children Detail Page"),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                color: Colors.grey,
              ),
              width: MediaQuery.of(context).size.width,
              height: 16,
            ),
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 110,
                  color: Colors.grey,
                ),
                Center(
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(99),
                          child: Image.network(
                            widget.children.personal_picture ??
                                "https://img4.thuthuatphanmem.vn/uploads/2020/12/26/hinh-nen-one-piece-chibi-cute_120602855.jpg",
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 110,
                        top: 115,
                        child: InkWell(
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey,
                                border: Border.all(color: Colors.white)),
                            child: Center(
                              child: Icon(Icons.camera_alt),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Center(
              child: Text(
                widget.children.name,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            ElevatedButton(
              // Edit
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            EditChildren(children: widget.children)));
              },
              child: Text('Edit Children Profile'),
            ),
            ChildrenInfo(
              widget: widget,
              label: "Gender",
              value: widget.children.gender.toString(),
            ),
            ChildrenInfo(
              widget: widget,
              label: "Age",
              value: widget.children.age.toString(),
            ),
            ChildrenInfo(
              widget: widget,
              label: "Status",
              value: widget.children.status.toString(),
            ),
            ChildrenInfo(
              widget: widget,
              label: "Join Date",
              value: DateFormat("yyyy-MM-dd")
                  .format(DateFormat("yyyy-MM-dd'T'HH:mm:ss")
                      .parse(widget.children.join_date))
                  .toString(),
            ),
            ChildrenInfo(
              widget: widget,
              label: "Active",
              value: widget.children.is_active.toString(),
            )
          ],
        ),
      ),
    );
  }
}

class ChildrenInfo extends StatelessWidget {
  final String label;
  final String value;
  const ChildrenInfo({
    Key? key,
    required this.widget,
    required this.label,
    required this.value,
  }) : super(key: key);

  final ChildrenDetail widget;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Text(
            label,
            style: TextStyle(fontSize: 24),
          ),
        ),
        Expanded(
            flex: 1,
            child: Text(
              " : ",
              style: TextStyle(fontSize: 24),
            )),
        Expanded(
            flex: 7,
            child: Text(
              value,
              style: TextStyle(fontSize: 24),
            ))
      ],
    );
  }
}
