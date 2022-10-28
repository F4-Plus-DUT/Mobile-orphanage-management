import 'package:flutter/material.dart';
import 'package:orphanage_management_system/pages/utils.dart';
import '../models/activity.dart';
import 'package:flutter_html/flutter_html.dart';

class ActivityDetail extends StatefulWidget {
  final Activity activity;

  const ActivityDetail({super.key, required this.activity});
  @override
  State<StatefulWidget> createState() => _ActivityDetailState();
}

class _ActivityDetailState extends State<ActivityDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Activity Detail Page"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Expanded(
            child: Column(
              children: [
                Stack(
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
                  ],
                ),

                Center(
                    child: SingleChildScrollView(
                      child: Html(
                        data: """
                        + ${widget.activity.content} + 
                      """,
                        defaultTextStyle: TextStyle(
                          fontSize: 10.0,
                        ),

                        padding: EdgeInsets.all(5.0),
                        onLinkTap: (url) {
                        },
                      ),
                    ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
