import 'package:orphanage_management_system/models/activity.dart';

class fact_comment {
  String? id;
  Account? account;
  String? content;
  String? updatedAt;
  String? parent;
  List<fact_comment> comments;
  fact_comment(
      {this.id,
      this.account,
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
          id: comments[i].id,
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
      for (var j = 0; j < data.length; j++) {
        if (data[j].id == comments[i].parent) {
          fact_comment a = new fact_comment(
              id: comments[i].id,
              account: comments[i].account,
              content: comments[i].content,
              updatedAt: comments[i].updatedAt,
              parent: comments[i].parent,
              comments: []);
          data[j].comments.add(a);
          print(data[j].comments);
        }
      }
    }
  }
  return data;
}
