import 'dart:convert';

import 'package:rib_reviews/env/env.dart';
import 'package:rib_reviews/models/event.dart';
import 'package:rib_reviews/models/review.dart';
import 'package:rib_reviews/models/user.dart';
import 'package:rib_reviews/utils/api.dart';

class ReviewSaveService {
  static Future<Review> save(
      double rating, String text, User user, Event event) async {
    try {
      final reviewsUrl = Env.apiPath('/reviews');

      final response = await API.post(
        reviewsUrl,
        json.encode({
          "rating": rating,
          "text": text,
          "createdAt": DateTime.now().toString(),
          "userId": user.id,
          "eventId": event.id
        }),
      );

      return Review.fromJson(jsonDecode(response), user);
    } on Exception catch (_) {
      return Future.error("Could not save review.");
    }
  }
}
