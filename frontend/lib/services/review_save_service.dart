import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:rib_reviews/env/env.dart';
import 'package:rib_reviews/models/event.dart';
import 'package:rib_reviews/models/review.dart';
import 'package:rib_reviews/models/user.dart';

class ReviewSaveService {
  static Future<Review> save(
      double rating, String text, User user, Event event) async {
    final client = http.Client();

    try {
      var uri = Env.localhost == 'true' ? Uri.http : Uri.https;
      final reviewsUrl = uri(Env.apiUrl, '/api/reviews');

      final response = await _post(
        client,
        reviewsUrl,
        json.encode({
          "rating": rating,
          "text": text,
          "createdAt": DateTime.now().toString(),
          "userId": user.id,
          "eventId": event.id
        }),
      );

      dynamic raw = jsonDecode(response);

      Review review = _toReview(raw, user);

      return review;
    } on Exception catch (_) {
      return Future.error("Could not save review.");
    } finally {
      client.close();
    }
  }

  static Review _toReview(dynamic review, User user) {
    return Review(
        id: review['_id'],
        rating: review['rating'].toDouble(),
        text: review['text'],
        user: user,
        createdAt: DateTime.parse(review['createdAt']),
        eventId: review['eventId']);
  }

  static Future<String> _post(http.Client client, Uri url, Object body) async {
    Response response = await client.post(url, body: body, headers: {
      "Authorization": Env.apiKey,
      "Content-Type": "application/json"
    });

    return response.body;
  }
}
