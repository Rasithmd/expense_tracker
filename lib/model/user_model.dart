import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? userId;
  String emailId;
  String password;
  String name;
  String number;
  String profile;

  String fcmToken;
  UserModel(
      {required this.emailId,
      this.userId,
      required this.password,
      required this.fcmToken,
      required this.name,
      required this.number,
      required this.profile});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'emailId': emailId,
      'password': password,
      'fcmToken': fcmToken,
      'name': name,
      'number': number,
      'profile': profile,
    };
  }

  factory UserModel.fromMap(DocumentSnapshot<Map<String, dynamic>> map) {
    return UserModel(
      userId: map.id,
      emailId: map['emailId'] ?? '',
      password: map['password'] ?? '',
      fcmToken: map['fcmToken'] ?? '',
      name: map['name'] ?? '',
      number: map['number'] ?? '',
      profile: map['profile'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());
  static UserModel singleUser = UserModel(
      userId: '',
      emailId: '',
      password: '',
      fcmToken: '',
      name: '',
      number: '',
      profile: '');

  static List<UserModel> allUsers = List<UserModel>.empty(growable: true);

  factory UserModel.fromJson(String source) => UserModel.fromMap(
      json.decode(source) as DocumentSnapshot<Map<String, dynamic>>);
}
