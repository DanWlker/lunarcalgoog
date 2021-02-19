import 'package:flutter/material.dart';

class DateSetScreen extends StatefulWidget {
  @override
  _DateSetScreenState createState() => _DateSetScreenState();
}

class _DateSetScreenState extends State<DateSetScreen> {
  DateTime selectedDate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedDate = DateTime.now();
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
                                  '${selectedDate.toLocal()}'.split(' ')[0], //split string into a list then display the first one
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  //delete
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 128, 161, 192),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      )
                    ),
                    onPressed: () {},
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
                  ),
                  //save
                  TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 128, 161, 192),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          )
                      ),
                      onPressed: () {},
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
                  )
                ],
              )
            ],
          ),
        ),
      )
    );
  }

  //date picker
  pickDate(BuildContext context) async {
    DateTime datePicked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2300),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark(),
          child: child,
        );
      }
    );

    if (datePicked != null && datePicked != selectedDate)
      setState(() {
        selectedDate = datePicked;
      });
  }
}
