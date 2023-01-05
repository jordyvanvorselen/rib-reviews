import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../utils/constants.dart';

class ErrorAlert {
  show(BuildContext context, String error) {
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
      title: "Oops! An error occured...",
      desc: error,
      buttons: [
        DialogButton(
          onPressed: () => Navigator.pop(context),
          color: Colors.grey.shade600,
          radius: BorderRadius.circular(25),
          child: const Text(
            "Close",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ],
    ).show();
  }
}
