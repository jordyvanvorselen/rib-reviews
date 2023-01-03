import 'package:rib_reviews/models/user.dart';

class Review {
  final double rating;
  final String text;
  final User user;

  Review({required this.rating, required this.text, required this.user});
}
