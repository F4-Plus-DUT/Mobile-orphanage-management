import '../pages/utils.dart';

class Activity {
  String? id;
  List<Comments>? comments;
  String? createdAt;
  String? updatedAt;
  String? title;
  String? content;
  String? location;
  String? startDate;
  String? endDate;
  String? coverPicture;
  double? expense;
  String? activityType;

  Activity(
      {this.id,
        this.comments,
        this.createdAt,
        this.updatedAt,
        this.title,
        this.content,
        this.location,
        this.startDate,
        this.endDate,
        this.coverPicture,
        this.expense,
        this.activityType});

  Activity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments?.add(new Comments.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    title = Utility.utf8convert(json['title']);
    content = Utility.utf8convert(json['content']);
    location = Utility.utf8convert(json['location']);
    startDate = json['start_date'];
    endDate = json['end_date'];
    coverPicture = json['cover_picture'];
    expense = json['expense'];
    activityType = json['activity_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.comments != null) {
      data['comments'] = this.comments?.map((v) => v.toJson()).toList();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['title'] = this.title;
    data['content'] = this.content;
    data['location'] = this.location;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['cover_picture'] = this.coverPicture;
    data['expense'] = this.expense;
    data['activity_type'] = this.activityType;
    return data;
  }
}

class Comments {
  Account? account;
  String? content;
  String? updatedAt;
  String? parent;

  Comments({this.account, this.content, this.updatedAt, this.parent});

  Comments.fromJson(Map<String, dynamic> json) {
    account =
    json['account'] != null ? new Account.fromJson(json['account']) : null;
    content = Utility.utf8convert(json['content']);
    updatedAt = json['updated_at'];
    parent = json['parent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.account != null) {
      data['account'] = this.account?.toJson();
    }
    data['content'] = this.content;
    data['updated_at'] = this.updatedAt;
    data['parent'] = this.parent;
    return data;
  }
}

class Account {
  String? id;
  String? name;
  String? avatar;
  String? email;

  Account({this.id, this.name, this.avatar, this.email});

  Account.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = Utility.utf8convert(json['name']);
    avatar = json['avatar'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['avatar'] = this.avatar;
    data['email'] = this.email;
    return data;
  }
}
