import 'dart:convert';

import 'package:rib_reviews/env/env.dart';
import 'package:rib_reviews/models/user.dart';
import 'package:rib_reviews/utils/api.dart';

class UserSaveService {
  API apiClient;

  UserSaveService({required this.apiClient});

  Future<User> save(String email, String? photoUrl, String displayName) async {
    try {
      final usersUrl = Env.apiPath('/users');

      var response = (await apiClient
              .post(
                usersUrl,
                json.encode({
                  "email": email,
                  "photoUrl": photoUrl,
                  "displayName": displayName,
                }),
              )
              .run())
          .getOrElse((l) => throw l);

      return User.fromJson(jsonDecode(response.body));
    } on Exception catch (e) {
      return Future.error(e.toString());
    }
  }
}
