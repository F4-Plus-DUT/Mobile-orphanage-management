import 'dart:convert';
import 'dart:io';

import 'package:comment_box/comment/comment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orphanage_management_system/models/activity.dart';
import 'package:orphanage_management_system/pages/utils.dart';
import 'package:http/http.dart' as http;

class CommentPage extends StatefulWidget {
  final String activity_id;

  const CommentPage({super.key, required this.activity_id});
  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  ValueNotifier<List<Comments>> all_comments =
      new ValueNotifier<List<Comments>>([]);
  String comment_url = Utility.BASE_URL + 'api/v1/activity/comment';
  Future<List<Comments>> getAllComments(String activity_id) async {
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
    return comments;
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

  Widget commentChild(data) {
    return ListView(
      children: [
        for (var i = 0; i < data.length; i++)
          Padding(
            padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
            child: ListTile(
              leading: GestureDetector(
                onTap: () async {
                  // Display the image in large form.
                  print("Comment Clicked");
                },
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: new BoxDecoration(
                      color: Colors.blue,
                      borderRadius: new BorderRadius.all(Radius.circular(50))),
                  child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                          data[i].account.avatar ?? Utility.DEFAULT_AVATAR)),
                ),
              ),
              title: Text(
                data[i].account.name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(data[i].content),
              trailing: SizedBox(
                  height: 28,
                  width: 50,
                  child: InkWell(
                    onTap: () async {
                      await deletecomment(data[i].id);
                      await getAllComments(widget.activity_id)
                          .then((value) => {all_comments.value = value});
                    },
                    child: Text(
                      "Delete",
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                    ),
                  )),
            ),
          )
      ],
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
              return commentChild(all_comments.value);
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
