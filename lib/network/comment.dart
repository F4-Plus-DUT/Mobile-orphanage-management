import 'dart:convert';
import 'dart:io';

import 'package:orphanage_management_system/helper/list_comment.dart';
import 'package:orphanage_management_system/models/activity.dart';
import 'package:orphanage_management_system/pages/utils.dart';
import 'package:http/http.dart' as http;

class CommentNetwork {
  static String comment_url = Utility.BASE_URL + 'api/v1/activity/comment';
  static Future<List<fact_comment>> getAllComments(String activity_id) async {
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

  static Future<void> commentSuccessfully(
      String text, String activity_id, String? parent_id) async {
    await http
        .post(Uri.parse(comment_url),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              HttpHeaders.authorizationHeader: 'Bearer ' + Utility.ACCESS_TOKEN,
            },
            body: jsonEncode(<String, String>{
              'activity': activity_id,
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

  static Future<void> ReplyComment(
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
      print(response.statusCode);
      if (response.statusCode == 201) {
        print("============DONE=============");
        print(Utility.ACCESS_TOKEN);
        print(response.body);
      }
    });
  }

  static Future<void> deletecomment(String comment_id) async {
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
}
