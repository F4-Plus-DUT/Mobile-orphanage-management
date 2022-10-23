import 'package:orphanage_management_system/pages/utils.dart';

class Activity {
  String? id;
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
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    title = Utility.utf8convert(json['title']);
    content = Utility.utf8convert(json['content']);
    location = Utility.utf8convert(json['location']);
    startDate = json['start_date'];
    endDate = json['end_date'];
    coverPicture = json['cover_picture'];
    expense = json['expense'];
    activityType = Utility.utf8convert(json['activity_type']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
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
