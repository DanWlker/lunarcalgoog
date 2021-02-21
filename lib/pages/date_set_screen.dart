import 'package:flutter/material.dart';
import 'package:lunarcalgoog/objects_widgets/action_passer.dart';
import 'package:lunarcalgoog/objects_widgets/event_info.dart';

class DateSetScreen extends StatefulWidget {
  EventInfo event;

  DateSetScreen({this.event});

  @override
  _DateSetScreenState createState() => _DateSetScreenState();
}

class _DateSetScreenState extends State<DateSetScreen> {
  final titleController = TextEditingController();
  final repeatController = TextEditingController();
  DateTime dateController;
  bool showDelete = true;

  @override
  void dispose() {
    titleController.dispose();
    repeatController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    if(widget.event == null) {
      widget.event = EventInfo(
          eventID: '${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}${DateTime.now().hour}${DateTime.now().minute}${DateTime.now().millisecond}${DateTime.now().microsecond}',
          title: '',
          dateTime: DateTime.now(),
          repeatFor: 0);
      showDelete = false;
    }
    // TODO: implement initState
    titleController.text = widget.event.title;
    dateController = widget.event.dateTime;
    repeatController.text = widget.event.repeatFor.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 59, 66, 82),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 59, 66, 82),
        elevation: 0,
      ),

      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 23, 20, 0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // Title
              TextField(
                controller: titleController,
                cursorColor: Color.fromARGB(255, 236, 239, 244),
                style: TextStyle(
                  color: Color.fromARGB(255, 236, 239, 244),
                  fontSize: 25,
                  fontFamily: 'ProductSans',
                ),
                decoration: InputDecoration(
                  labelText: 'Title',
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 236, 239, 244),
                    fontSize: 20,
                    letterSpacing: 0.9,
                    fontFamily: 'ProductSans',
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 236, 239, 244)
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 236, 239, 244),
                    ),
                  ),
                )
              ),
              SizedBox(height: 59),
              // Date Chooser
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(),
                  Text(
                    'Select date of birth',
                    style: TextStyle(
                      color: Color.fromARGB(255, 236, 239, 244),
                      fontSize: 20,
                      letterSpacing: 0.9,
                      fontFamily: 'ProductSans',
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: TextButton(
                            onPressed: () {
                              return pickDate(context);
                            },
                            style: ButtonStyle(
                              overlayColor: MaterialStateProperty.resolveWith((state) => Colors.transparent),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  '${dateController.toLocal()}'.split(' ')[0], //split string into a list then display the first one
                                  style: TextStyle(
                                    fontFamily: 'Product Sans',
                                    fontSize: 50,
                                    color: Color.fromARGB(255, 236, 239, 244),
                                  ),
                                ),
                              ]
                            )
                        ),
                      ),
                    ]
                  )


                ],
              ),
              SizedBox(height: 34),
              //Repeat for how many years
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      flex: 2,
                      child: Icon(
                        Icons.replay,
                        color: Color.fromARGB(255, 236, 239, 244),
                      )
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(
                      'Repeat for',
                      style: TextStyle(
                        fontFamily: 'ProductSans',
                        fontSize: 20,
                        letterSpacing: 0.9,
                        color: Color.fromARGB(255, 236, 239, 244),
                      )
                    )
                  ),
                  Expanded(
                    flex: 5,
                    child: TextField(
                        controller: repeatController,
                        cursorColor: Color.fromARGB(255, 236, 239, 244),
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          color: Color.fromARGB(255, 236, 239, 244),
                          fontSize: 25,
                          fontFamily: 'ProductSans',
                        ),
                        decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 236, 239, 244)
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 236, 239, 244),
                              ),
                            ),
                            hintText: 'X',
                            hintStyle: TextStyle(
                              color: Color.fromARGB(255, 236, 239, 244),
                              fontSize: 20,
                              fontFamily: 'ProductSans',
                              letterSpacing: 0.9
                          )
                        )
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      '  years',
                      style: TextStyle(
                        fontFamily: 'ProductSans',
                        fontSize: 20,
                        letterSpacing: 0.9,
                        color: Color.fromARGB(255, 236, 239, 244),
                      )
                    )
                  )
                ],
              ),
              SizedBox(height: 75),
              //save and delete
              drawButtons(),
            ],
          ),
        ),
      )
    );
  }

  //date picker
  void pickDate(BuildContext context) async {
    DateTime datePicked = await showDatePicker(
      context: context,
      initialDate: widget.event.dateTime,
      firstDate: DateTime(1900),
      lastDate: DateTime(2300),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark(),
          child: child,
        );
      }
    );

    if (datePicked != null && datePicked != dateController)
      setState(() {
        dateController = datePicked;
      });
  }

  //show delete or not
  Widget drawButtons() {
    if(showDelete)
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          //delete
          deleteButton(),
          //save
          saveButton(),
        ],
      );
    else
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          //save
          saveButton(),
        ],
      );;
  }

  Widget deleteButton() => TextButton(
      style: TextButton.styleFrom(
          backgroundColor: Color.fromARGB(255, 128, 161, 192),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          )
      ),
      onPressed: () {
        Navigator.pop(context, ActionPasser(action: 'Delete'));
      },

      child: Padding(
        padding: const EdgeInsets.fromLTRB(3, 5, 3, 5),
        child: Row(
          children: [
            Icon(
              Icons.delete,
              color: Color.fromARGB(255, 229, 233, 240),
            ),
            Text(
                'Delete',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'ProductSans',
                  letterSpacing: 0.9,
                  color: Color.fromARGB(255, 229, 233, 240),
                )
            ),
          ],
        ),
      )
  );

  Widget saveButton() => TextButton(
      style: TextButton.styleFrom(
          backgroundColor: Color.fromARGB(255, 128, 161, 192),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          )
      ),
      onPressed: () {
        Navigator.pop(
            context,
            ActionPasser(
                action: 'Save',
                eventInfo: EventInfo(
                  eventID: widget.event.eventID,
                  title: titleController.text,
                  dateTime: dateController,
                  repeatFor: int.parse(repeatController.text),
                )
            ));
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(6, 5, 6, 5),
        child: Row(
          children: [
            Icon(
              Icons.save,
              color: Color.fromARGB(255, 229, 233, 240),
            ),
            Text(
                'Save',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'ProductSans',
                  letterSpacing: 0.9,
                  color: Color.fromARGB(255, 229, 233, 240),
                )
            ),
          ],
        ),
      )
  );
}
