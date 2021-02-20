import 'package:flutter/material.dart';
import 'package:lunarcalgoog/pages/date_set_screen.dart';
import '../objects_widgets/event_info.dart';
import '../objects_widgets/app_card_one.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  DateTime time = DateTime.now();

  List<EventInfo> events;
  int counter;

  @override
  void initState() {
    events = [
      EventInfo(eventID: '0', title: 'Wang Yi Lin', dateTime: DateTime.now(), repeatFor: 5),
      EventInfo(eventID: '1', title: 'Zheng Zong Qi', dateTime: new DateTime(1990, 3, 4), repeatFor: 3),
      EventInfo(eventID: '2', title: 'Bookman', dateTime: new DateTime(2000, 2, 2), repeatFor: 4),
    ];
    // TODO: implement initState
    super.initState();
  }

  @override //build will override the base class build function
  Widget build(BuildContext context) {
    counter = 0;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 46, 52, 64),
      appBar: AppBar(
        title: Text(
            "Lunar Google Calendar Tool",
            style: TextStyle(
              fontFamily:'ProductSans',
            )
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 59, 66, 82),
      ),

      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 35, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: events.map((event) {
            counter = counter + 1;
            return AppCardOne(
                event: event,
                cardId: counter,
                delete: () {
                  setState(() {
                    events.remove(event);
                  });
                },
                save: (EventInfo eventFromChild) {
                  setState(() {
                    for(int i = 0; i < events.length; ++i) {
                      if(events[i].eventID == eventFromChild.eventID) {
                        events[i] = eventFromChild;
                        break;
                      }
                    }
                  });
                }
            );
          }).toList(),
        ),
      ),

      floatingActionButton: FloatingActionButton(
          onPressed: () {
            _returnFromEventCreatePage(context);
          },
          backgroundColor:Color.fromARGB(255, 229, 233, 240),
          child: Icon(
            Icons.add,
            color: Color.fromARGB(255, 59, 66, 82),
          )
      ),
    );
  }

  _returnFromEventCreatePage(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => DateSetScreen(),
      ),
    );

    setState(() {
      if(result.action == 'Save')
        events.add(result.eventInfo);
    });

  }
}