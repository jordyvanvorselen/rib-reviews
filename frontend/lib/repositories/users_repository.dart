import 'dart:convert';

import 'package:rib_reviews/env/env.dart';
import 'package:rib_reviews/models/user.dart';
import 'package:rib_reviews/utils/api.dart';

class UsersRepository {
  static Future<List<User>> all() async {
    try {
      final usersUrl = Env.apiUrl("/users");
      final usersResponse = await API.get(usersUrl);

      List<User> users = jsonDecode(usersResponse)
          .map<User>((json) => User.fromJson(json))
          .toList();

      return users;
    } on Exception catch (_) {
      return Future.error("Could not fetch users from the server.");
    }
  }
}
