import 'package:rib_reviews/models/reaction.dart';
import 'package:rib_reviews/models/review.dart';
import 'package:rib_reviews/models/user.dart';
import 'package:rib_reviews/utils/api.dart';

class ReactionsRepository {
  API apiClient;

  ReactionsRepository({required this.apiClient});

  Future<List<Reaction>> all(
      List<User> allUsers, List<Review> allReviews) async {
    try {
      final reactionsResponse =
          (await apiClient.get('/reactions').run()).getOrElse((l) => throw l);

      List<Reaction> reactions = reactionsResponse.data.map<Reaction>((json) {
        final userIds = json['userIds'] as List<dynamic>;
        final reviewId = json['reviewId'] as String;

        return Reaction.fromJson(
          json,
          allUsers.where((u) => userIds.contains(u.id)).toList(),
          allReviews.firstWhere((r) => r.id == reviewId),
        );
      }).toList();

      return reactions;
    } on Exception catch (_) {
      return Future.error("Could not fetch users from the server.");
    }
  }
}
