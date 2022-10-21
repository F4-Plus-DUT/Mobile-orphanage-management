import 'package:orphanage_management_system/pages/utils.dart';

class User {
  String? id;
  String? name;
  int? gender;
  String? email;
  String? password;
  String? avatar;
  String? birthday;
  String? address;
  List<Roles>? roles;
  String? occupation;
  String? phone;

  User(
      {this.id,
        this.name,
        this.gender,
        this.email,
        this.password,
        this.avatar,
        this.birthday,
        this.address,
        this.roles,
        this.occupation,
        this.phone});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = Utility.utf8convert(json['name']);
    gender = json['gender'];
    email = json['email'];
    password = json['password'];
    avatar = json['avatar'];
    birthday = json['birthday'];
    address = json['address'];
    if (json['roles'] != null) {
      roles = <Roles>[];
      json['roles'].forEach((v) {
        roles!.add(new Roles.fromJson(v));
      });
    }
    occupation = json['occupation'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['personal_email'] = this.email;
    data['password'] = this.password;
    data['avatar'] = this.avatar;
    data['birthday'] = this.birthday;
    data['address'] = this.address;
    if (this.roles != null) {
      data['roles'] = this.roles!.map((v) => v.toJson()).toList();
    }
    data['occupation'] = this.occupation;
    data['phone'] = this.phone;
    return data;
  }
}

class Roles {
  String? id;
  String? name;

  Roles({this.id, this.name});

  Roles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}