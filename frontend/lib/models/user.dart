import 'dart:convert';

import 'package:crypto/crypto.dart';

class User {
  final String email;
  final String? photoUrl;
  final String displayName;

  User({
    required this.email,
    required this.photoUrl,
    required this.displayName,
  });

  String getPhotoUrl() {
    return photoUrl ?? "https://www.gravatar.com/avatar/${generateMd5(email)}";
  }

  String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }
}
