import 'package:flutter/material.dart';
import 'package:rib_reviews/models/event.dart';
import 'package:rib_reviews/utils/constants.dart';
import 'package:url_launcher/url_launcher_string.dart';

class EventLink extends StatelessWidget {
  final Event event;

  const EventLink({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 125,
      child: IconButton(
        tooltip: "Go to website",
        onPressed: () {
          launchUrlString(event.venue.website,
              mode: LaunchMode.externalApplication);
        },
        icon: Icon(Icons.open_in_new),
        iconSize: 40,
        color: kSecondaryTextColor,
      ),
    );
  }
}
