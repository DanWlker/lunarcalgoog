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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lunar Google Calendar Tool',
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 35, 20, 0),
        child: ListView.builder(
          itemCount: widget.events.length,
          itemBuilder: (context, index) {
            final event = widget.events[index];
            return AppCardOne(
              event: event,
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
        child: const Icon(
          Icons.add,
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
