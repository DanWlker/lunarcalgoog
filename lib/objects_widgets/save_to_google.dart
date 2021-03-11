import 'dart:io';
import 'package:googleapis_auth/auth_io.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:lunar_calendar_converter/lunar_solar_converter.dart';
import 'package:lunarcalgoog/objects_widgets/event_info.dart';
import 'package:lunarcalgoog/objects_widgets/lun_sol_converter.dart';
import 'package:retry/retry.dart';
import 'package:url_launcher/url_launcher.dart';

class SaveToGoogle {
  static const _scopes = const[CalendarApi.calendarScope];
  static var _credentials;
  static bool assigned = false;

  static void assignClientID() {
    if (Platform.isAndroid) {
      _credentials = new ClientId(
        "690477293202-jdq06bjdc537t7pc57qchptcejlm6g8s.apps.googleusercontent.com",
        "");
    } else if (Platform.isIOS) {
      _credentials = new ClientId(
        "690477293202-vt0idmk14tf3rf7rrb6m93mq8sppjk5h.apps.googleusercontent.com",
        "");
    }
  }

  static void insertEvent(EventInfo eventInfo) async {
    if(!assigned) {
      assignClientID();
      assigned = true;
    }

    List<Event> eventsToSend = [];

    for(int i = 0; i < eventInfo.repeatFor; ++i) {
      Lunar lunCurrEventDate = LunSolConverter.solTolun(eventInfo.dateTime);
      lunCurrEventDate.lunarYear = eventInfo.yearModified.toInt() + i;
      DateTime currEventDate = LunSolConverter.lunToSol(lunCurrEventDate);

      Event event = Event();
      event.summary = eventInfo.title;

      EventDateTime start = new EventDateTime();
      start.timeZone = "GMT+8:00";
      start.date = currEventDate;
      event.start = start;

      EventDateTime end = new EventDateTime();
      end.timeZone = "GMT+8:00";
      end.date = currEventDate;
      event.end = end;

      event.id = '${eventInfo.eventID}$i';

      eventsToSend.add(event);
    }

    for(int i = 0; i < eventsToSend.length; ++i) {
      print('${eventsToSend[i].id}, ${eventsToSend[i].start.date.toString()}, ${eventsToSend[i].end.date.toString()}');
    }

    clientViaUserConsent(_credentials, _scopes, prompt).then((AuthClient client) async {
      var calendar = CalendarApi(client);
      String calendarId = "primary";

      int i = 0;
      while (i < eventsToSend.length) {
        final r = RetryOptions(maxAttempts: 8);
        final response = await r.retry(
              () => calendar.events.insert(eventsToSend[i], calendarId),
              retryIf: (e) => e is Exception,
        );
        print("hi");
        ++i;
      }
    });
  }

  static void deleteEvent(EventInfo eventInfo) async {
    if(!assigned) {
      assignClientID();
      assigned = true;
    }

    List<Event> eventsToSend = [];

    for(int i = 0; i < eventInfo.repeatFor; ++i) {
      Lunar lunCurrEventDate = LunSolConverter.solTolun(eventInfo.dateTime);
      lunCurrEventDate.lunarYear = eventInfo.yearModified+ i;
      DateTime currEventDate = LunSolConverter.lunToSol(lunCurrEventDate);

      Event event = Event();
      event.summary = eventInfo.title;

      EventDateTime start = new EventDateTime();
      start.timeZone = "GMT+8:00";
      start.date = currEventDate;
      event.start = start;

      EventDateTime end = new EventDateTime();
      end.timeZone = "GMT+8:00";
      end.date = currEventDate;
      event.end = end;

      event.id = '${eventInfo.eventID}$i';

      eventsToSend.add(event);
    }

    for(int i = 0; i < eventsToSend.length; ++i) {
      print('${eventsToSend[i].id}, ${eventsToSend[i].start.date.toString()}, ${eventsToSend[i].end.date.toString()}');
    }

    clientViaUserConsent(_credentials, _scopes, prompt).then((AuthClient client) async {
      var calendar = CalendarApi(client);
      calendar.calendarList.list().then((value) => print("VAL: $value"));

      String calendarId = "primary";

      int i = 0;
      while (i < eventsToSend.length) {
        final r = RetryOptions(maxAttempts: 8);
        final response = await r.retry(
              () => calendar.events.delete(calendarId, eventsToSend[i].id),
          retryIf: (e) => e is Exception,
        );
        print("hi");
        ++i;
      }
    });
  }

  static void editEvent(EventInfo oldEvent, EventInfo newEvent) async {
    deleteEvent(oldEvent);
    insertEvent(newEvent);
  }

  static void prompt(String url) async {
    print("Please go to the following URL to grant access: ");
    print(" => $url");
    print("");

    if(await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}