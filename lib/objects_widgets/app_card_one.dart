import 'package:flutter/material.dart';
import 'package:lunarcalgoog/pages/date_set_screen.dart';
import 'event_info.dart';

class AppCardOne extends StatefulWidget {
  EventInfo event;
  int cardId;

  AppCardOne({this.event, this.cardId});

  @override
  _AppCardOneState createState() => _AppCardOneState();
}

class _AppCardOneState extends State<AppCardOne> {
  List< List<int> > cardColor = [
    [255, 229, 233, 240],
    [255, 216, 222, 233]
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DateSetScreen(event: widget.event)
                      ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(9)),
                  ),
                  primary: Color.fromARGB(
                      cardColor[widget.cardId%2][0],
                      cardColor[widget.cardId%2][1],
                      cardColor[widget.cardId%2][2],
                      cardColor[widget.cardId%2][3]),
                  ),
                child: Container(
                  padding: EdgeInsets.fromLTRB(8, 20, 8, 20),
                  child: Row(
                      children: <Widget>[
                        Expanded(
                          flex:1,
                          child: Text(
                            widget.event.title,
                            style: TextStyle(
                              fontFamily: 'ProductSans',
                              fontSize: 20.0,
                              letterSpacing: 0.9,
                              color: Color.fromARGB(255, 59, 66, 82),
                            ),
                          ),
                        ),
                        Expanded(
                            flex:1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  '阴历${widget.event.dateTime.month.toString()}月${widget.event.dateTime.day.toString()}日',
                                  style: TextStyle(
                                    fontFamily: 'ProductSans',
                                    fontSize: 20.0,
                                    letterSpacing: 0.9,
                                    color: Color.fromARGB(255, 59, 66, 82),
                                  ),
                                ),
                              ],
                            )
                        )
                      ]
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height:20),
      ],
    );
  }
}
