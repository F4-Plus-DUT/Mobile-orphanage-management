import 'package:orphanage_management_system/pages/utils.dart';

class User {
  String? id;
  String? name;
  int? gender;
  String? email;
  String? avatar;
  String? birthday;
  String? address;
  late Roles roles;
  String? occupation;
  String? phone;

  User(
      {this.id,
      this.name,
      this.gender,
      this.email,
      this.avatar,
      this.birthday,
      this.address,
      required this.roles,
      this.occupation,
      this.phone});

  User.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    name = Utility.utf8convert(json['name'] ?? " - ");
    gender = json['gender'];
    email = json['email'] ?? " - ";
    avatar = json['avatar'];
    birthday = json['birthday'];
    address = json['address'] ?? " - ";
    roles = new Roles.fromJson(json['roles']);
    occupation = json['occupation'] ?? " - ";
    phone = json['phone'] ?? " - ";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['personal_email'] = this.email;
    data['avatar'] = this.avatar;
    data['birthday'] = this.birthday;
    data['address'] = this.address;
    data['roles'] = this.roles.toJson();
    data['occupation'] = this.occupation;
    data['phone'] = this.phone;
    return data;
  }
}

class Roles {
  String? id;
  String? name;
  late int levels;

  Roles({this.id, this.name, required this.levels});

  Roles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    levels = json['levels'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['levels'] = this.levels;
    return data;
  }
}
