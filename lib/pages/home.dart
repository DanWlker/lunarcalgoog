import 'package:flutter/material.dart';
import 'package:lunarcalgoog/objects_widgets/action_passer.dart';
import 'package:lunarcalgoog/objects_widgets/app_card_one.dart';
import 'package:lunarcalgoog/objects_widgets/event_info.dart';
import 'package:lunarcalgoog/objects_widgets/save_and_read.dart';
import 'package:lunarcalgoog/objects_widgets/save_to_google.dart';
import 'package:lunarcalgoog/pages/date_set_screen.dart';

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
          style: TextStyle(
            fontFamily: 'ProductSans',
          ),
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
                  SaveToGoogle.deleteEvent(event);
                  widget.events.remove(event);
                  SaveAndRead.writeData(EventInfo.encode(widget.events));
                });
              },
              save: (EventInfo eventFromChild) {
                setState(() {
                  eventFromChild.yearModified = DateTime.now().year;
                  for (var i = 0; i < widget.events.length; ++i) {
                    if (widget.events[i].eventID == eventFromChild.eventID) {
                      SaveToGoogle.editEvent(
                        widget.events[i],
                        eventFromChild,
                      );
                      widget.events[i] = eventFromChild;
                      break;
                    }
                  }
                  SaveAndRead.writeData(EventInfo.encode(widget.events));
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
    final result = await navigatorState.push<ActionPasser>(
      MaterialPageRoute(
        builder: (context) => DateSetScreen(),
      ),
    );

    if (!mounted) return;

    setState(() {
      if (result != null && result.action == 'Save') {
        result.eventInfo.yearModified = DateTime.now().year;
        widget.events.add(result.eventInfo);
        SaveAndRead.writeData(EventInfo.encode(widget.events));
        SaveToGoogle.insertEvent(result.eventInfo);
      }
    });
  }
}

