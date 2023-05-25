import 'dart:convert';

import 'package:crypto/crypto.dart';

class User {
  final String id;
  final String email;
  final String? photoUrl;
  final String displayName;

  User({
    required this.id,
    required this.email,
    required this.photoUrl,
    required this.displayName,
  });

  factory User.fromJson(dynamic json) {
    return User(
      id: json['_id'],
      displayName: json['displayName'],
      email: json['email'],
      photoUrl: json['photoUrl'],
    );
  }

  String get photoUrlWithFallback {
    return photoUrl ?? "https://www.gravatar.com/avatar/${generateMd5(email)}";
  }

  String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }
}
