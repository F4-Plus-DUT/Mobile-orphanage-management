import 'dart:convert';
import 'dart:io';

import 'package:comment_box/comment/comment.dart';
import 'package:comment_tree/widgets/comment_tree_widget.dart';
import 'package:comment_tree/widgets/tree_theme_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orphanage_management_system/helper/datetime.dart';
import 'package:orphanage_management_system/helper/list_comment.dart';
import 'package:orphanage_management_system/models/activity.dart';
import 'package:orphanage_management_system/network/comment.dart';
import 'package:orphanage_management_system/pages/utils.dart';
import 'package:http/http.dart' as http;

class CommentPage extends StatefulWidget {
  final String activity_id;

  const CommentPage({super.key, required this.activity_id});
  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  ValueNotifier<List<fact_comment>> all_comments =
      new ValueNotifier<List<fact_comment>>([]);
  String comment_url = Utility.BASE_URL + 'api/v1/activity/comment';
  Future<List<fact_comment>> getAllComments(String activity_id) async {
    print("================DEBUG================");
    print(Utility.ACCESS_TOKEN);
    print(activity_id);
    List<Comments> comments = [];
    String comments_url =
        Utility.BASE_URL + "api/v1/activity/comment?activity=" + activity_id;
    final response = await http.get(
      Uri.parse(comments_url),
    );
    var body = json.decode(response.body);
    print(body);
    List<Map<String, dynamic>> listComments = body.cast<Map<String, dynamic>>();
    comments = listComments.map((e) => Comments.fromJson(e)).toList();

    final a = parseComments(comments);
    // print("==============================CONVERT=====================");
    // print(a[0].comments);
    // print(a[1].comments);
    return a;
  }

  Future<void> commentSuccessfully(String text) async {
    await http
        .post(Uri.parse(comment_url),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              HttpHeaders.authorizationHeader: 'Bearer ' + Utility.ACCESS_TOKEN,
            },
            body: jsonEncode(<String, String>{
              'activity': widget.activity_id,
              'content': text,
              'parent': ''
            }))
        .then((response) {
      if (response.statusCode == 201) {
        print("============DONE=============");
        print(Utility.ACCESS_TOKEN);
        print(response.body);
      }
    });
  }

  Future<void> ReplyComment(
      String activity_id, String text, String comment_id) async {
    await http
        .post(Uri.parse(comment_url),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              HttpHeaders.authorizationHeader: 'Bearer ' + Utility.ACCESS_TOKEN,
            },
            body: jsonEncode(<String, String>{
              'activity': activity_id,
              'content': text,
              'parent': comment_id
            }))
        .then((response) {
      if (response.statusCode == 201) {
        print("============DONE=============");
        print(Utility.ACCESS_TOKEN);
        print(response.body);
      }
    });
  }

  Future<void> deletecomment(String comment_id) async {
    String delete_url = comment_url + "/" + comment_id;
    print(delete_url);
    await http.delete(
      Uri.parse(delete_url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer ' + Utility.ACCESS_TOKEN,
      },
    ).then((response) {
      print("===============DELETE =================");
      print(response.statusCode);
      if (response.statusCode == 204) {
        print("============DONE DELETE=============");
      }
    });
  }

  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
  List<Comments> comments = [];

  @override
  void initState() {
    getAllComments(widget.activity_id)
        .then((value) => {all_comments.value = value});
    super.initState();
  }

  Widget CommentChildPage(List<fact_comment> data) {
    return Container(
      padding: const EdgeInsets.only(top: 16),
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        itemCount: data.length,
        itemBuilder: (_, index) {
          return Comment_Item(data[index], widget.activity_id);
        },
      ),
    );
  }

  Widget Comment_Item(fact_comment comment, String activity_id) {
    return Container(
      child: CommentTreeWidget<fact_comment, fact_comment>(
        comment,
        comment.comments,
        treeThemeData:
            TreeThemeData(lineColor: Colors.grey.shade50, lineWidth: 3),
        avatarRoot: (context, data) => PreferredSize(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(99),
            child: Image.network(
              data.account?.avatar ?? Utility.DEFAULT_AVATAR,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            // radius: 20.0,
          ),
          preferredSize: Size.fromRadius(18),
        ),
        avatarChild: (context, data) => PreferredSize(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(99),
            child: Image.network(
              data.account?.avatar ?? Utility.DEFAULT_AVATAR,
              width: 30,
              height: 30,
              fit: BoxFit.cover,
            ),
            // radius: 20.0,
          ),
          preferredSize: Size.fromRadius(99),
        ),
        contentChild: (context, data) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.account?.name ?? "-",
                      style: Theme.of(context).textTheme.caption?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: 15,
                          ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      '${data.content}',
                      style: Theme.of(context).textTheme.caption?.copyWith(
                            fontWeight: FontWeight.w300,
                            color: Colors.black,
                            fontSize: 14,
                          ),
                    ),
                  ],
                ),
              ),
              DefaultTextStyle(
                style: Theme.of(context).textTheme.caption!.copyWith(
                    color: Colors.grey[700], fontWeight: FontWeight.bold),
                child: Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Row(
                    children: [
                      Text(
                        commented(data.updatedAt ??
                            "2022-01-01T17:40:05.419238+07:00"),
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.normal),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      InkWell(
                        onTap: (() async {
                          print("=======================DEBUG===============");
                          var text = commentController.text;
                          commentController.clear();
                          FocusScope.of(context).unfocus();
                          await CommentNetwork.ReplyComment(
                              widget.activity_id, text, data.id ?? "");
                          await getAllComments(widget.activity_id)
                              .then((value) => {all_comments.value = value});
                          // parseComments(all_comments.value);
                        }),
                        child: Text(
                          "Reply",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.normal),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      InkWell(
                        onTap: () async {
                          await CommentNetwork.deletecomment(data.id ?? "");
                          await CommentNetwork.getAllComments(
                                  widget.activity_id)
                              .then((value) => {all_comments.value = value});
                        },
                        child: Text(
                          "Delete",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.normal),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        },
        contentRoot: (context, data) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.account?.name ?? "",
                      style: Theme.of(context).textTheme.caption!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 15),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      '${data.content}',
                      style: Theme.of(context).textTheme.caption!.copyWith(
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                          fontSize: 14),
                    ),
                  ],
                ),
              ),
              DefaultTextStyle(
                style: Theme.of(context).textTheme.caption!.copyWith(
                    color: Colors.grey[700], fontWeight: FontWeight.bold),
                child: Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Row(
                    children: [
                      Text(
                        commented(data.updatedAt ??
                            "2022-01-01T17:40:05.419238+07:00"),
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.normal),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      InkWell(
                        onTap: (() async {
                          print("=======================DEBUG===============");
                          var text = commentController.text;
                          commentController.clear();
                          FocusScope.of(context).unfocus();
                          await CommentNetwork.ReplyComment(
                              widget.activity_id, text, data.id ?? "");
                          await getAllComments(widget.activity_id)
                              .then((value) => {all_comments.value = value});
                          // parseComments(all_comments.value);
                        }),
                        child: Text(
                          "Reply",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.normal),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      InkWell(
                        onTap: () async {
                          await CommentNetwork.deletecomment(data.id ?? "");
                          await CommentNetwork.getAllComments(
                                  widget.activity_id)
                              .then((value) => {all_comments.value = value});
                        },
                        child: Text(
                          "Delete",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.normal),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Comment Page"),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        child: CommentBox(
          userImage: Utility.CURRENT_PROFILE.avatar ?? Utility.DEFAULT_AVATAR,
          // child: commentChild(comments),
          child: ValueListenableBuilder(
            valueListenable: all_comments,
            builder: ((context, value, child) {
              return CommentChildPage(all_comments.value);
            }),
          ),
          labelText: 'Write a comment...',
          withBorder: false,
          errorText: 'Comment cannot be blank',
          sendButtonMethod: () async {
            if (formKey.currentState!.validate()) {
              var text = commentController.text;
              commentController.clear();
              FocusScope.of(context).unfocus();
              await commentSuccessfully(text);
              await getAllComments(widget.activity_id)
                  .then((value) => {all_comments.value = value});
              //FIND A WAY TO RELOAD DATA FROM SERVER
            } else {
              print("Not validated");
            }
          },
          formKey: formKey,
          commentController: commentController,
          backgroundColor: Colors.white,
          sendWidget: Icon(Icons.send_sharp, size: 30, color: Colors.orange),
        ),
      ),
    );
  }
}
