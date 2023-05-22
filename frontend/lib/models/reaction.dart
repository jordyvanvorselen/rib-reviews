import 'dart:convert';

import 'package:rib_reviews/models/review.dart';
import 'package:rib_reviews/models/user.dart';

class Reaction {
  final String id;
  final String emoji;
  final List<User> users;
  final Review review;

  Reaction({
    required this.id,
    required this.emoji,
    required this.users,
    required this.review,
  });

  factory Reaction.fromJson(dynamic json, List<User> users, Review review) {
    return Reaction(
      id: json['_id'],
      emoji: json['emoji'],
      users: users,
      review: review,
    );
  }

  String toJson() {
    return json.encode({
      "emoji": emoji,
      "userIds": users.map((e) => e.id).toList(),
      "reviewId": review.id,
    });
  }

  bool isPlacedBy(User user) {
    return users.where((u) => u.id == user.id).isNotEmpty;
  }

  Reaction setUsers(List<User> users) {
    users = users;

    return this;
  }
}
