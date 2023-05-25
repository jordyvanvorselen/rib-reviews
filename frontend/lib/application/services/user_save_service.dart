import 'dart:convert';

import 'package:rib_reviews/data/api.dart';
import 'package:rib_reviews/domain/models/user.dart';

class UserSaveService {
  API apiClient;

  UserSaveService({required this.apiClient});

  Future<User> save(String email, String? photoUrl, String displayName) async {
    try {
      var response = (await apiClient
              .post(
                '/users',
                json.encode({
                  "email": email,
                  "photoUrl": photoUrl,
                  "displayName": displayName,
                }),
              )
              .run())
          .getOrElse((l) => throw l);

      return User.fromJson(response.data);
    } on Exception catch (e) {
      return Future.error(e.toString());
    }
  }
}
