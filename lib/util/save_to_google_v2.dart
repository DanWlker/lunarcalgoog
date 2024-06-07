import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:lunarcalgoog/entity/event_info.dart';

class SaveToGoogleV2 {
  SaveToGoogleV2._();

  static final instance = SaveToGoogleV2._();

  final _googleSignIn = GoogleSignIn(
    scopes: <String>[CalendarApi.calendarEventsScope],
  );

  static void deleteEvent(EventInfo event) {}

  static void editEvent(EventInfo event, EventInfo eventFromChild) {}

  static void insertEvent(EventInfo eventInfo) {}
}
