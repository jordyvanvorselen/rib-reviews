import 'package:rib_reviews/data/api.dart';
import 'package:rib_reviews/domain/models/review.dart';
import 'package:rib_reviews/domain/models/user.dart';

class ReviewsRepository {
  API apiClient;

  ReviewsRepository({required this.apiClient});

  Future<List<Review>> all(List<User> users) async {
    try {
      final reviewsResponse =
          (await apiClient.get('/reviews').run()).getOrElse((l) => throw l);

      List<Review> reviews = reviewsResponse.data
          .map<Review>((raw) => Review.fromJson(
                raw,
                users.firstWhere((u) => u.id == raw['userId']),
              ))
          .toList();

      reviews.sort(((a, b) => b.createdAt.compareTo(a.createdAt)));

      return reviews;
    } on Exception catch (_) {
      return Future.error("Could not fetch data from server.");
    }
  }
}
