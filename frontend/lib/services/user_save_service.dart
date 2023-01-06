import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:rib_reviews/env/env.dart';
import 'package:rib_reviews/models/user.dart';

class UserSaveService {
  static var client = http.Client();

  static Future<User> save(
      String email, String? photoUrl, String displayName) async {
    try {
      var usersUrl = Uri.https(Env.apiUrl, '/api/users');
      var response = await _post(
        client,
        usersUrl,
        json.encode({
          "email": email,
          "photoUrl": photoUrl,
          "displayName": displayName,
        }),
      );

      dynamic raw = jsonDecode(response);

      User user = _toUser(raw);

      return user;
    } on Exception catch (_) {
      return Future.error("Could not save user.");
    } finally {
      client.close();
    }
  }

  static User _toUser(dynamic user) {
    return User(
      id: user["_id"],
      email: user["email"],
      photoUrl: user["photoUrl"],
      displayName: user["displayName"],
    );
  }

  static Future<String> _post(http.Client client, Uri url, Object body) async {
    Response response = await client.post(url, body: body, headers: {
      "Authorization": Env.apiKey,
      "Content-Type": "application/json"
    });

    return response.body;
  }
}
