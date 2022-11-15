import 'package:orphanage_management_system/models/activity.dart';

class fact_comment {
  String? id;
  Account? account;
  String? content;
  String? updatedAt;
  String? parent;
  List<Comments> comments;
  fact_comment(
      {this.account,
      this.content,
      this.updatedAt,
      this.parent,
      required this.comments});
}

List<fact_comment> parseComments(List<Comments> comments) {
  List<fact_comment> data = [];
  for (var i = 0; i < comments.length; i++) {
    if (comments[i].parent == null) {
      fact_comment a = new fact_comment(
          account: comments[i].account,
          content: comments[i].content,
          updatedAt: comments[i].updatedAt,
          parent: comments[i].parent,
          comments: []);
      data.add(a);
    }
  }
  for (var i = 0; i < comments.length; i++) {
    if (comments[i].parent != null) {
      print("===============REPLY============");
      print(comments[i].parent);
      for (var j = 0; j < data.length; j++) {
        if (data[j].parent == comments[i].parent) {
          data[j].comments.add(comments[i]);
        }
      }
    }
  }
  return data;
}
