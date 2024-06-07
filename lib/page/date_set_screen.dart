import 'package:flutter/material.dart';
import 'package:lunarcalgoog/entity/actions.dart';
import 'package:lunarcalgoog/entity/event_info.dart';
import 'package:lunarcalgoog/util/lun_sol_converter.dart';

class DateSetScreen extends StatefulWidget {
  const DateSetScreen({
    this.event,
    super.key,
  });
  final EventInfo? event;

  @override
  State<DateSetScreen> createState() => _DateSetScreenState();
}

class _DateSetScreenState extends State<DateSetScreen> {
  final titleController = TextEditingController();
  final repeatController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  @override
  void dispose() {
    titleController.dispose();
    repeatController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    titleController.text = widget.event?.title ?? '';
    if (widget.event?.dateTime case final DateTime eventDate) {
      selectedDate = eventDate;
    }
    repeatController.text = widget.event?.repeatFor.toString() ?? '0';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 59, 66, 82),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 59, 66, 82),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 23, 20, 0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // Title
              TextField(
                controller: titleController,
                cursorColor: const Color.fromARGB(255, 236, 239, 244),
                style: const TextStyle(
                  color: Color.fromARGB(255, 236, 239, 244),
                  fontSize: 25,
                ),
                decoration: const InputDecoration(
                  labelText: 'Title',
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 236, 239, 244),
                    fontSize: 20,
                    letterSpacing: 0.9,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 236, 239, 244),
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 236, 239, 244),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 60),
              // Date Chooser
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(),
                  const Text(
                    'Select date of birth',
                    style: TextStyle(
                      color: Color.fromARGB(255, 236, 239, 244),
                      fontSize: 20,
                      letterSpacing: 0.9,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            pickDate(context);
                          },
                          style: ButtonStyle(
                            overlayColor: WidgetStateProperty.resolveWith(
                              (state) => Colors.transparent,
                            ),
                            padding: WidgetStateProperty.resolveWith(
                              (state) => EdgeInsets.zero,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                '${selectedDate.toLocal()}'.split(' ')[0],
                                style: const TextStyle(
                                  fontSize: 40,
                                  color: Color.fromARGB(255, 236, 239, 244),
                                ),
                              ),
                              const Icon(
                                Icons.arrow_drop_down_rounded,
                                size: 70,
                                color: Color.fromARGB(255, 236, 239, 244),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 27),
              //Show the selected date in lunar
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(),
                  const Text(
                    'Date in lunar calendar',
                    style: TextStyle(
                      color: Color.fromARGB(255, 236, 239, 244),
                      fontSize: 20,
                      letterSpacing: 0.9,
                    ),
                  ),
                  Text(
                    '${LunSolConverter.solTolun(selectedDate.toLocal())}',
                    style: const TextStyle(
                      color: Color.fromARGB(255, 236, 239, 244),
                      fontSize: 30,
                      letterSpacing: 0.9,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(height: 42),
              //Repeat for how many years
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    flex: 2,
                    child: Icon(
                      Icons.replay,
                      color: Color.fromARGB(255, 236, 239, 244),
                    ),
                  ),
                  const Expanded(
                    flex: 5,
                    child: Text(
                      'Repeat for',
                      style: TextStyle(
                        fontSize: 20,
                        letterSpacing: 0.9,
                        color: Color.fromARGB(255, 236, 239, 244),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: TextField(
                      controller: repeatController,
                      cursorColor: const Color.fromARGB(255, 236, 239, 244),
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 236, 239, 244),
                        fontSize: 25,
                      ),
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 236, 239, 244),
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
                          letterSpacing: 0.9,
                        ),
                      ),
                    ),
                  ),
                  const Expanded(
                    flex: 3,
                    child: Text(
                      '  years',
                      style: TextStyle(
                        fontSize: 20,
                        letterSpacing: 0.9,
                        color: Color.fromARGB(255, 236, 239, 244),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 70),
              //save and delete
              drawButtons(),
            ],
          ),
        ),
      ),
    );
  }

  //date picker
  Future<void> pickDate(BuildContext context) async {
    final datePicked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2300),
    );

    if (datePicked == null || datePicked.compareTo(selectedDate) == 0) return;

    setState(() {
      selectedDate = datePicked;
    });
  }

  //show delete or not
  Widget drawButtons() {
    final eventId = widget.event?.eventID;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        //delete
        if (eventId != null) deleteButton(eventId),
        //save
        saveButton(),
      ],
    );
  }

  Widget deleteButton(String eventId) => TextButton(
        style: TextButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 128, 161, 192),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),
        onPressed: () {
          Navigator.pop(context, DeleteAction(eventId));
        },
        child: const Padding(
          padding: EdgeInsets.fromLTRB(3, 5, 3, 5),
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
                  letterSpacing: 0.9,
                  color: Color.fromARGB(255, 229, 233, 240),
                ),
              ),
            ],
          ),
        ),
      );

  Widget saveButton() => TextButton(
        style: TextButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 128, 161, 192),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),
        onPressed: () {
          Navigator.pop(
            context,
            SaveAction(
              EventInfo(
                eventID: widget.event?.eventID,
                title: titleController.text,
                dateTime: selectedDate,
                repeatFor: int.parse(repeatController.text),
              ),
            ),
          );
        },
        child: const Padding(
          padding: EdgeInsets.fromLTRB(6, 5, 6, 5),
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
                  letterSpacing: 0.9,
                  color: Color.fromARGB(255, 229, 233, 240),
                ),
              ),
            ],
          ),
        ),
      );
}
