import 'package:rib_reviews/models/review.dart';
import 'package:rib_reviews/models/user.dart';

class Reaction {
  final String emoji;
  final List<User> users;
  final Review review;

  Reaction({
    required this.emoji,
    required this.users,
    required this.review,
  });

  factory Reaction.fromJson(dynamic json, List<User> users, Review review) {
    return Reaction(
      emoji: json['emoji'],
      users: users,
      review: review,
    );
  }
}
