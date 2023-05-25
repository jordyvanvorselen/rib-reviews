import 'package:rib_reviews/data/api.dart';
import 'package:rib_reviews/domain/models/reaction.dart';
import 'package:rib_reviews/domain/models/review.dart';
import 'package:rib_reviews/domain/models/user.dart';

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
