import 'package:flutter/material.dart';

class AppUser extends ChangeNotifier {
  String? appUserId;
  String? userName;
  String? userEmail;
  String? phoneNumber;
  String? description;
  String? password;
  String? confirmPassword;
  bool? isFirstLogin;
  String? createdAt;
  String? imageUrl;
  String? coverImageUrl;
  String? lastMessage;
  String? lastMessageAt;

  AppUser({
    this.appUserId,
    this.userEmail,
    this.userName,
    this.phoneNumber,
    this.description,
    this.password,
    this.confirmPassword,
    this.isFirstLogin,
    this.createdAt,
    this.imageUrl,
    this.coverImageUrl,
    this.lastMessage,
    this.lastMessageAt,
  });

  AppUser.fromJson(json, id) {
    this.appUserId = id;
    this.userName = json['userName'];
    this.userEmail = json['userEmail'];
    this.phoneNumber = json['phoneNumber'] ?? '';
    this.password = json['password'];
    this.description = json['description'] ?? '';
    this.isFirstLogin = json['isFirstLogin'];
    this.createdAt = json['createdAt'];
    this.imageUrl = json['imageUrl'];
    this.coverImageUrl = json['coverImageUrl'];
    this.lastMessage = json['lastMessage'] ?? '';
    this.lastMessageAt = json['lastMessageAt'];
  }

  toJson() {
    return {
      'appUserId': this.appUserId,
      'userName': this.userName,
      'userEmail': this.userEmail,
      'phoneNumber': this.phoneNumber,
      'password': this.password,
      'description': this.description,
      'isFirstLogin': this.isFirstLogin,
      'createdAt': this.createdAt,
      'imageUrl': this.imageUrl,
      'coverImageUrl':this.coverImageUrl,
      'lastMessage': this.lastMessage,
      'lastMessageAt': this.lastMessageAt,
    };
  }
}
