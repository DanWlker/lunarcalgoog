import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lunarcalgoog/entity/actions.dart';
import 'package:lunarcalgoog/entity/event_info.dart';
import 'package:lunarcalgoog/page/date_set_screen.dart';
import 'package:lunarcalgoog/util/save_and_read.dart';
import 'package:lunarcalgoog/util/save_to_google_v2.dart';
import 'package:lunarcalgoog/widget/app_card_one.dart';

class Home extends StatefulWidget {
  const Home({
    required this.events,
    super.key,
  });

  final List<EventInfo> events;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Color> cardColors = [
    const Color.fromARGB(255, 229, 233, 240),
    const Color.fromARGB(255, 216, 222, 233),
  ];

  @override //build will override the base class build function
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 46, 52, 64),
      appBar: AppBar(
        title: const Text(
          'Lunar Google Calendar Tool',
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 59, 66, 82),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 35, 20, 0),
        child: ListView.builder(
          itemCount: widget.events.length,
          itemBuilder: (context, index) {
            final event = widget.events[index];
            return AppCardOne(
              event: event,
              color: cardColors[index % cardColors.length],
              delete: () {
                setState(() {
                  SaveToGoogleV2.deleteEvent(event);
                  widget.events.remove(event);
                  SaveAndRead.writeData(jsonEncode(widget.events));
                });
              },
              save: (EventInfo eventFromChild) {
                setState(() {
                  for (var i = 0; i < widget.events.length; ++i) {
                    if (widget.events[i].eventID == eventFromChild.eventID) {
                      SaveToGoogleV2.editEvent(
                        widget.events[i],
                        eventFromChild,
                      );
                      widget.events[i] = eventFromChild;
                      break;
                    }
                  }
                  SaveAndRead.writeData(jsonEncode(widget.events));
                });
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final navigatorState = Navigator.of(context);
          _returnFromEventCreatePage(navigatorState);
        },
        backgroundColor: const Color.fromARGB(255, 229, 233, 240),
        child: const Icon(
          Icons.add,
          color: Color.fromARGB(255, 59, 66, 82),
        ),
      ),
    );
  }

  Future<void> _returnFromEventCreatePage(NavigatorState navigatorState) async {
    final result = await navigatorState.push<EventActions>(
      MaterialPageRoute(
        builder: (context) => const DateSetScreen(),
      ),
    );

    if (!mounted || result == null) return;

    if (result case SaveAction(:final event)) {
      setState(() {
        widget.events.add(event);
        SaveAndRead.writeData(jsonEncode(widget.events));
        SaveToGoogleV2.insertEvent(event);
      });
    }
  }
}
