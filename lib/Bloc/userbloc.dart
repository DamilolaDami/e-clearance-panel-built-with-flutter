import 'package:flutter/material.dart';

class User {
  late int? id;
  late String? name;
  late String? email;
  late String? token;
  late int? type;
  late String? mobile;
  late String? family;
  late bool active;
  late String? createdAt;
  late String? lastLogin;

  User({
    this.id,
    this.name,
    this.email,
    this.token,
    this.type,
    required this.active,
    this.createdAt,
    this.lastLogin,
    this.mobile,
    this.family,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email']; 
    type = json['type'];
    active = json['active'] == 1;
    createdAt = json['created_at'];
    lastLogin = json['last_login'];
    mobile = json['mobile'];
    family = json['family'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;

    data['token'] = this.token;
    data['type'] = this.type;
    data['active'] = this.active ? 1 : 0;
    data['created_at'] = this.createdAt;
    data['last_login'] = this.lastLogin;
    return data;
  }

  String get typeName => this.type == 1 ? 'Admin' : this.type ==2 ? 'Teacher': 'Student';


}
