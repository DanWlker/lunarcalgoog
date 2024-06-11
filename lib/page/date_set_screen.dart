import 'package:flutter/material.dart';
import 'package:lunarcalgoog/entity/actions.dart';
import 'package:lunarcalgoog/entity/event_info.dart';
import 'package:lunarcalgoog/util/lun_sol_converter.dart';
import 'package:lunarcalgoog/util/random_id_generator.dart';

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
    repeatController.text = widget.event?.repeatFor.toString() ?? '1';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                style: const TextStyle(
                  fontSize: 25,
                ),
                decoration: const InputDecoration(
                  labelText: 'Title',
                  labelStyle: TextStyle(
                    fontSize: 20,
                    letterSpacing: 0.9,
                  ),
                  enabledBorder: UnderlineInputBorder(),
                  focusedBorder: UnderlineInputBorder(),
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
                                ),
                              ),
                              const Icon(
                                Icons.arrow_drop_down_rounded,
                                size: 70,
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
                      fontSize: 20,
                      letterSpacing: 0.9,
                    ),
                  ),
                  Text(
                    '${LunSolConverter.solTolun(selectedDate.toLocal())}',
                    style: const TextStyle(
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
                  const Icon(
                    Icons.replay,
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    flex: 5,
                    child: Text(
                      'Repeat for',
                      style: TextStyle(
                        fontSize: 20,
                        letterSpacing: 0.9,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: TextField(
                      controller: repeatController,
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                        fontSize: 25,
                      ),
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(),
                        focusedBorder: UnderlineInputBorder(),
                        hintText: 'X',
                        hintStyle: TextStyle(
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
              ),
              Text(
                'Delete',
                style: TextStyle(
                  fontSize: 20,
                  letterSpacing: 0.9,
                ),
              ),
            ],
          ),
        ),
      );

  Widget saveButton() => TextButton(
        style: TextButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),
        onPressed: () {
          Navigator.pop(
            context,
            SaveAction(
              EventInfo(
                eventID: uuid.v4().replaceAll('-', ''),
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
              ),
              Text(
                'Save',
                style: TextStyle(
                  fontSize: 20,
                  letterSpacing: 0.9,
                ),
              ),
            ],
          ),
        ),
      );
}
