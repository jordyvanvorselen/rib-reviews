import 'package:rib_reviews/data/api.dart';
import 'package:rib_reviews/domain/models/user.dart';

class UsersRepository {
  API apiClient;

  UsersRepository({required this.apiClient});

  Future<List<User>> all() async {
    try {
      final usersResponse =
          (await apiClient.get('/users').run()).getOrElse((l) => throw l);

      List<User> users =
          usersResponse.data.map<User>((json) => User.fromJson(json)).toList();

      return users;
    } on Exception catch (_) {
      return Future.error("Could not fetch users from the server.");
    }
  }
}
