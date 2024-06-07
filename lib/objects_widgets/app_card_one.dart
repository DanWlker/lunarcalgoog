import 'package:flutter/material.dart';
import 'package:lunarcalgoog/objects_widgets/action_passer.dart';
import 'package:lunarcalgoog/objects_widgets/event_info.dart';
import 'package:lunarcalgoog/objects_widgets/lun_sol_converter.dart';
import 'package:lunarcalgoog/pages/date_set_screen.dart';

class AppCardOne extends StatelessWidget {
  const AppCardOne({
    required this.event,
    required this.delete,
    required this.save,
    required this.color,
    super.key,
  });

  final EventInfo event;
  final Function delete;
  final Function save;
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
                  _returnFromEventEditPage(context);
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
                                fontFamily: 'ProductSans',
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

  _returnFromEventEditPage(BuildContext context) async {
    final ActionPasser result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DateSetScreen(event: event),
      ),
    );

    if (result.action == 'Save') {
      widget.event = result.eventInfo;
      save(event);
    } else if (result.action == 'Delete') {
      delete();
    } else {}
  }
}
