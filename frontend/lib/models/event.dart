import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

import './venue.dart';

class Event {
  final DateTime? date;
  final Venue venue;

  Event({required this.date, required this.venue});

  Color getIndicatorColor() {
    if (date == null) {
      return Colors.grey;
    }

    if (date!.difference(DateTime.now()).isNegative) {
      return Colors.green;
    }

    return Colors.orange;
  }

  getIcon() {
    final color = getIndicatorColor();

    if (color.value == Colors.grey.value) {
      return Icons.pending;
    } else if (color.value == Colors.green.value) {
      return Icons.done;
    } else {
      return Icons.event;
    }
  }

  IndicatorStyle getIndicatorStyle() {
    return IndicatorStyle(
      color: getIndicatorColor(),
      padding: EdgeInsets.all(5),
      width: 50.0,
      iconStyle: IconStyle(
        color: Colors.white,
        iconData: getIcon(),
        fontSize: 35.0,
      ),
    );
  }
}
