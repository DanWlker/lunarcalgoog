import 'package:lunarcalgoog/entity/event_info.dart';

sealed class EventActions {}

class SaveAction implements EventActions {
  SaveAction(this.event);

  final EventInfo event;
}

class DeleteAction implements EventActions {
  DeleteAction(this.eventId);

  final String eventId;
}

