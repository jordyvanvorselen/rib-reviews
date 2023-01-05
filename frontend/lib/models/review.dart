import 'package:intl/intl.dart';
import 'package:rib_reviews/models/user.dart';

class Review {
  final String id;
  final double rating;
  final String text;
  final User user;
  final DateTime createdAt;
  final String eventId;

  Review({
    required this.id,
    required this.rating,
    required this.text,
    required this.user,
    required this.createdAt,
    required this.eventId,
  });

  String getFormattedDate() {
    return DateFormat.yMMMMd('en_US').format(createdAt);
  }
}
