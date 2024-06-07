import 'package:flutter/material.dart';
import 'package:lunarcalgoog/entity/actions.dart';
import 'package:lunarcalgoog/entity/event_info.dart';
import 'package:lunarcalgoog/page/date_set_screen.dart';
import 'package:lunarcalgoog/util/lun_sol_converter.dart';

class AppCardOne extends StatelessWidget {
  const AppCardOne({
    required this.event,
    required this.delete,
    required this.save,
    required this.color,
    super.key,
  });

  final EventInfo event;
  final VoidCallback delete;
  final void Function(EventInfo) save;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: <Widget>[
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  final navigatorState = Navigator.of(context);
                  _returnFromEventEditPage(navigatorState);
                },
                style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(9)),
                  ),
                  backgroundColor: color,
                ),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(4, 20, 4, 20),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          event.title,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              LunSolConverter.solTolun(event.dateTime)
                                  .toString(),
                              style: const TextStyle(
                                fontSize: 17,
                                letterSpacing: 0.9,
                                color: Color.fromARGB(255, 59, 66, 82),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Future<void> _returnFromEventEditPage(NavigatorState navigatorState) async {
    final result = await navigatorState.push<EventActions>(
      MaterialPageRoute(
        builder: (context) => DateSetScreen(event: event),
      ),
    );

    switch (result) {
      case null:
        break;
      case SaveAction(:final event):
        save(event);
      case DeleteAction():
        delete();
    }
  }
}
