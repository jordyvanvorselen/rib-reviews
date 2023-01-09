import 'dart:convert';

import 'package:rib_reviews/env/env.dart';
import 'package:rib_reviews/models/review.dart';
import 'package:rib_reviews/models/user.dart';
import 'package:rib_reviews/utils/api.dart';

class ReviewsRepository {
  static Future<List<Review>> all(List<User> users) async {
    try {
      final reviewsUrl = Env.apiUrl("/reviews");
      final reviewsResponse = await API.get(reviewsUrl);

      List<Review> reviews = jsonDecode(reviewsResponse)
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
