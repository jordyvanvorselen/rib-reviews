import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../mocks/mock_events.dart';
import '../models/event.dart';
import '../utils/constants.dart';

class Timeline extends StatefulWidget {
  const Timeline({Key? key}) : super(key: key);

  @override
  State<Timeline> createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  List<Event> events = MockEvents.data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TimelineTile(
          indicatorStyle: getIndicatorStyle(Colors.grey),
          beforeLineStyle: LineStyle(color: kBackgroundColor, thickness: 5),
          afterLineStyle: LineStyle(color: Colors.grey, thickness: 5),
          endChild: Container(
            color: Colors.pink,
            constraints: const BoxConstraints(minHeight: 200),
          ),
        ),
        TimelineTile(
          indicatorStyle: getIndicatorStyle(Colors.green),
          beforeLineStyle: LineStyle(color: Colors.grey, thickness: 5),
          afterLineStyle: LineStyle(color: Colors.green, thickness: 5),
          endChild: Container(
            color: Colors.blue,
            constraints: const BoxConstraints(minHeight: 200),
          ),
        ),
        TimelineTile(
          indicatorStyle: getIndicatorStyle(Colors.green),
          beforeLineStyle: LineStyle(color: Colors.green, thickness: 5),
          afterLineStyle: LineStyle(color: Colors.green, thickness: 5),
          endChild: Container(
            color: Colors.pink,
            constraints: const BoxConstraints(minHeight: 200),
          ),
        ),
      ],
    );
  }

  IndicatorStyle getIndicatorStyle(Color color) {
    return IndicatorStyle(
      color: color,
      padding: EdgeInsets.all(5),
      width: 50.0,
    );
  }
}
