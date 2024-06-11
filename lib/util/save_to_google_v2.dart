import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:lunar/calendar/Lunar.dart';
import 'package:lunarcalgoog/entity/event_info.dart';
import 'package:lunarcalgoog/provider/google_sign_in_provider.dart';
import 'package:lunarcalgoog/util/lun_sol_converter.dart';
import 'package:retry/retry.dart';

class SaveToGoogleV2 {
  SaveToGoogleV2._();

  static final instance = SaveToGoogleV2._();

  static Future<void> deleteEvent(EventInfo event) async {
    await Fluttertoast.showToast(msg: 'Deleting... Do not close app');
    final client = await googleSignIn.authenticatedClient();

    if (client == null) {
      await Fluttertoast.showToast(msg: 'Client is null, have you logged in?');
      return;
    }

    final calendarApi = CalendarApi(client);
    for (var i = 0; i < event.repeatFor; ++i) {
      await retry(
        () => calendarApi.events.delete('primary', '${event.eventID}$i'),
      );
    }
    await Fluttertoast.showToast(msg: 'Delete successful');
  }

  static Future<void> editEvent(EventInfo oldEvent, EventInfo newEvent) async {
    try {
      await deleteEvent(oldEvent);
    } catch (_) {}
    await insertEvent(newEvent);
  }

  static Future<void> insertEvent(EventInfo eventInfo) async {
    await Fluttertoast.showToast(msg: 'Inserting event... Do not close app');
    final eventsToSend = <Event>[];

    for (var i = 0; i < eventInfo.repeatFor; ++i) {
      final eventDateLunar = LunSolConverter.solTolun(eventInfo.dateTime);
      final recordEventDateLunar = Lunar.fromYmd(
        eventDateLunar.getYear() + i,
        eventDateLunar.getMonth(),
        eventDateLunar.getDay(),
      );
      final recordEventDate = LunSolConverter.lunToSol(recordEventDateLunar);

      final event = Event(
        id: '${eventInfo.eventID}$i',
        summary: eventInfo.title,
        start: EventDateTime(date: recordEventDate),
        end: EventDateTime(
          date: recordEventDate.add(
            const Duration(days: 1),
          ),
        ),
      );

      eventsToSend.add(event);
    }

    for (var i = 0; i < eventsToSend.length; ++i) {
      print(
        '${eventsToSend[i].id}, ${eventsToSend[i].start?.date}, ${eventsToSend[i].end?.date}',
      );
    }

    final client = await googleSignIn.authenticatedClient();

    if (client == null) {
      await Fluttertoast.showToast(msg: 'Client is null, have you logged in?');
      return;
    }

    final calendarApi = CalendarApi(client);

    for (final event in eventsToSend) {
      await retry(
        () => calendarApi.events.insert(
          event,
          'primary',
        ),
      );
    }
    await Fluttertoast.showToast(msg: 'Insert successful');
  }
}
