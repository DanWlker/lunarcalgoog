import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lunarcalgoog/entity/actions.dart';
import 'package:lunarcalgoog/entity/event_info.dart';
import 'package:lunarcalgoog/page/date_set_screen.dart';
import 'package:lunarcalgoog/provider/event_list_provider.dart';
import 'package:lunarcalgoog/util/save_and_read.dart';
import 'package:lunarcalgoog/util/save_to_google_v2.dart';
import 'package:lunarcalgoog/widget/app_card_one.dart';

class Home extends ConsumerWidget {
  const Home({
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final events = ref.watch(eventListProvider).value;

    if (events == null) {
      return const SizedBox.shrink();
    }

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
          itemCount: events.length,
          itemBuilder: (context, index) {
            final event = events[index];
            return AppCardOne(
              event: event,
              delete: () {
                SaveToGoogleV2.deleteEvent(event);
                events.remove(event);
                SaveAndRead.writeData(jsonEncode(events));
              },
              save: (EventInfo eventFromChild) {
                for (var i = 0; i < events.length; ++i) {
                  if (events[i].eventID == eventFromChild.eventID) {
                    SaveToGoogleV2.editEvent(
                      events[i],
                      eventFromChild,
                    );
                    events[i] = eventFromChild;
                    break;
                  }
                }
                SaveAndRead.writeData(jsonEncode(events));
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final navigatorState = Navigator.of(context);
          _returnFromEventCreatePage(navigatorState, ref);
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }

  Future<void> _returnFromEventCreatePage(
    NavigatorState navigatorState,
    WidgetRef ref,
  ) async {
    final result = await navigatorState.push<EventActions>(
      MaterialPageRoute(
        builder: (context) => const DateSetScreen(),
      ),
    );
    if (result case SaveAction(:final event)) {
      final events = ref.read(eventListProvider).value;
      if (events == null) return;
      events.add(event);
      await SaveAndRead.writeData(jsonEncode(events));
      SaveToGoogleV2.insertEvent(event);
    }
  }
}
