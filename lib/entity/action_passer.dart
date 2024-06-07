import 'package:lunarcalgoog/entity/event_info.dart';

class ActionPasser {
  ActionPasser({
    required this.action,
    this.eventInfo,
  });

  String action;
  EventInfo? eventInfo;
}
