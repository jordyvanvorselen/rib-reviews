import 'dart:convert';

import 'package:rib_reviews/data/api.dart';
import 'package:rib_reviews/domain/models/event.dart';
import 'package:rib_reviews/domain/models/review.dart';
import 'package:rib_reviews/domain/models/user.dart';

class ReviewSaveService {
  API apiClient;

  ReviewSaveService({required this.apiClient});

  Future<Review> save(
      double rating, String text, User user, Event event) async {
    try {
      final response = (await apiClient
              .post(
                '/reviews',
                json.encode({
                  "rating": rating,
                  "text": text,
                  "createdAt": DateTime.now().toString(),
                  "userId": user.id,
                  "eventId": event.id
                }),
              )
              .run())
          .getOrElse((l) => throw l);

      return Review.fromJson(response.data, user);
    } on Exception catch (_) {
      return Future.error("Could not save review.");
    }
  }
}
