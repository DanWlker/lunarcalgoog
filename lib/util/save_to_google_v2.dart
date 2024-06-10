import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:lunar/calendar/Lunar.dart';
import 'package:lunarcalgoog/entity/event_info.dart';
import 'package:lunarcalgoog/provider/google_sign_in_provider.dart';
import 'package:lunarcalgoog/util/lun_sol_converter.dart';
import 'package:retry/retry.dart';

class SaveToGoogleV2 {
  SaveToGoogleV2._();

  static final instance = SaveToGoogleV2._();

  static void deleteEvent(EventInfo event) {}

  static void editEvent(EventInfo event, EventInfo eventFromChild) {}

  static Future<void> insertEvent(EventInfo eventInfo) async {
    final eventsToSend = <Event>[];

    for (var i = 0; i < eventInfo.repeatFor; ++i) {
      final eventDateLunar = LunSolConverter.solTolun(eventInfo.dateTime);
      final recordEventDateLunar = Lunar.fromYmd(
        eventDateLunar.getYear() + 1,
        eventDateLunar.getMonth(),
        eventDateLunar.getDay(),
      );
      final recordEventDate = LunSolConverter.lunToSol(recordEventDateLunar);

      final event = Event(
        id: '${eventInfo.eventID}_$i',
        summary: eventInfo.title,
        start: EventDateTime(date: recordEventDate),
      );

      eventsToSend.add(event);
    }

    for (var i = 0; i < eventsToSend.length; ++i) {
      print('${eventsToSend[i].id}, ${eventsToSend[i].start?.date}');
    }

    final client = await googleSignIn.authenticatedClient();

    if (client == null) {
      print('Client is null, have you logged in?');
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
  }
}
