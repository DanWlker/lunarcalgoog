import 'package:flutter/material.dart';
import 'package:lunarcalgoog/objects_widgets/action_passer.dart';
import 'package:lunarcalgoog/objects_widgets/save_and_read.dart';
import 'package:lunarcalgoog/objects_widgets/save_to_google.dart';
import 'package:lunarcalgoog/pages/date_set_screen.dart';
import '../objects_widgets/event_info.dart';
import '../objects_widgets/app_card_one.dart';

class Home extends StatefulWidget {
  List<EventInfo> events;
  Home({this.events});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int counter;

  @override
  void initState() {
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
          children: widget.events.map((event) {
            counter = counter + 1;
            return AppCardOne(
                event: event,
                cardId: counter,
                delete: () {
                  setState(() {
                    SaveToGoogle.deleteEvent(event);
                    widget.events.remove(event);
                    SaveAndRead.writeData(EventInfo.encode(widget.events).toString());
                  });
                },
                save: (EventInfo eventFromChild) {
                  setState(() {
                    eventFromChild.yearModified = DateTime.now().year.toInt();
                    for(int i = 0; i < widget.events.length; ++i) {
                      if(widget.events[i].eventID == eventFromChild.eventID) {
                        SaveToGoogle.editEvent(widget.events[i], eventFromChild);
                        widget.events[i] = eventFromChild;
                        break;
                      }
                    }
                    SaveAndRead.writeData(EventInfo.encode(widget.events).toString());
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


  void _returnFromEventCreatePage(BuildContext context) async {
    final ActionPasser result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => DateSetScreen(),
      ),
    );

    setState(() {
      if(result.action == 'Save')
        {
          result.eventInfo.yearModified = DateTime.now().year.toInt();
          widget.events.add(result.eventInfo);
          SaveAndRead.writeData(EventInfo.encode(widget.events).toString());
          SaveToGoogle.insertEvent(result.eventInfo);
        }
    });
  }

}