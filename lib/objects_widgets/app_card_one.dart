import 'package:flutter/material.dart';
import 'package:lunarcalgoog/objects_widgets/action_passer.dart';
import 'package:lunarcalgoog/objects_widgets/event_info.dart';
import 'package:lunarcalgoog/objects_widgets/lun_sol_converter.dart';
import 'package:lunarcalgoog/pages/date_set_screen.dart';

class AppCardOne extends StatefulWidget {

  AppCardOne({super.key, this.event, this.cardId, this.delete, this.save});
  EventInfo event;
  int cardId;
  Function delete;
  Function save;

  @override
  _AppCardOneState createState() => _AppCardOneState();
}

class _AppCardOneState extends State<AppCardOne> {
  List< List<int> > cardColor = [
    [255, 229, 233, 240],
    [255, 216, 222, 233],
  ];

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
                  ), backgroundColor: Color.fromARGB(
                      cardColor[widget.cardId%2][0],
                      cardColor[widget.cardId%2][1],
                      cardColor[widget.cardId%2][2],
                      cardColor[widget.cardId%2][3],),
                  ),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(4, 20, 4, 20),
                  child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            widget.event.title,
                            style: const TextStyle(
                              fontFamily: 'ProductSans',
                              fontSize: 17,
                              letterSpacing: 0.9,
                              color: Color.fromARGB(255, 59, 66, 82),
                            ),
                          ),
                        ),
                        Expanded(
                            flex:2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  LunSolConverter.solTolun(widget.event.dateTime).toString(),
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
        const SizedBox(height:20),
      ],
    );
  }

  _returnFromEventEditPage(BuildContext context) async {
    final ActionPasser result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DateSetScreen(event: widget.event),
      ),
    );

    if(result.action == 'Save') {
      widget.event = result.eventInfo;
      widget.save(widget.event);
    }
    else if(result.action == 'Delete') {
      widget.delete();
    }
    else {}
  }
}
