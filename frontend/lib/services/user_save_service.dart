import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rib_reviews/env/env.dart';
import 'package:rib_reviews/models/user.dart';
import 'package:rib_reviews/utils/api.dart';

class UserSaveService {
  static Future<User> save(
      String email, String? photoUrl, String displayName) async {
    final client = http.Client();

    try {
      final usersUrl = Env.apiUrl('/users');

      var response = await API.post(
        client,
        usersUrl,
        json.encode({
          "email": email,
          "photoUrl": photoUrl,
          "displayName": displayName,
        }),
      );

      return User.fromJson(jsonDecode(response));
    } on Exception catch (_) {
      return Future.error("Could not save user.");
    } finally {
      client.close();
    }
  }
}
