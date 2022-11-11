import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:orphanage_management_system/pages/donor.dart';
import 'package:orphanage_management_system/pages/utils.dart';
import '../models/activity.dart';
import 'package:flutter_html/flutter_html.dart';
import 'comment.dart';

class ActivityDetail extends StatefulWidget {
  final Activity activity;

  const ActivityDetail({super.key, required this.activity});
  @override
  State<StatefulWidget> createState() => _ActivityDetailState();
}

String current_donate(int amount) {
  if (amount == 0)
    return "0";
  else {
    return amount.toString() + "000";
  }
}

class _ActivityDetailState extends State<ActivityDetail> {
  bool isLike = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Activity Detail Page"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Center(
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            border: Border.all(color: Colors.white)),
                        child: ClipRRect(
                          // borderRadius: BorderRadius.circular(99),
                          child: Image.network(
                            widget.activity.coverPicture ??
                                Utility.DEFAULT_AVATAR,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                    child: SingleChildScrollView(
                  child: Html(
                    data: """ ${widget.activity.content} <hr> """,
                    defaultTextStyle: TextStyle(
                      fontSize: 14.0,
                    ),
                    padding: EdgeInsets.all(5.0),
                    onLinkTap: (url) {},
                    backgroundColor: Colors.white70,
                  ),
                )),
                Text(
                  "Estimated cost: " +
                      widget.activity.expense.toString() +
                      "  VND",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: (() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DonorPage(
                                activity_id: widget.activity.id ?? "")));
                  }),
                  child: Text(
                    "Current donate: " +
                        current_donate(widget.activity.donate ?? 0) +
                        "  VND",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(padding: EdgeInsets.only(top: 40.0, left: 20.0)),
                    GestureDetector(
                      onTap: () => {},
                      child: Icon(
                          isLike ? Icons.favorite : Icons.favorite_border,
                          size: 28.0,
                          color: Colors.pink),
                    ),
                    Padding(padding: EdgeInsets.only(right: 20.0)),
                    GestureDetector(
                      onTap: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CommentPage(
                                    activity_id: widget.activity.id!)))
                      },
                      child:
                          Icon(Icons.chat, size: 28.0, color: Colors.blue[900]),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
