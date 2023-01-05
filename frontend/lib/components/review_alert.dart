import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:rib_reviews/components/rating.dart';
import 'package:rib_reviews/models/event.dart';

import '../utils/constants.dart';

class ReviewAlert {
  show(BuildContext context, Event event) {
    var alertStyle = AlertStyle(
      animationType: AnimationType.grow,
      isCloseButton: false,
      isOverlayTapDismiss: true,
      descStyle: const TextStyle(color: kSecondaryTextColor, fontSize: 20),
      backgroundColor: kSecondaryColor,
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      titleStyle: const TextStyle(color: kPrimaryTextColor, fontSize: 32),
    );

    return Alert(
      context: context,
      style: alertStyle,
      type: AlertType.none,
      title: "Leave a review",
      desc: "How was your time at ${event.venue.name}?",
      content: Column(
        children: const [
          SizedBox(height: 25),
          Rating(rating: 0, showNumber: false, readOnly: false, size: 38),
          TextField(
              maxLength: 600, maxLines: 4, style: TextStyle(fontSize: 16)),
        ],
      ),
      buttons: [
        DialogButton(
          onPressed: () {},
          color: Colors.green,
          radius: BorderRadius.circular(25),
          child: const Text(
            "Save",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        DialogButton(
          onPressed: () => Navigator.pop(context),
          color: Colors.grey.shade600,
          radius: BorderRadius.circular(25),
          child: const Text(
            "Cancel",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ],
    ).show();
  }
}
