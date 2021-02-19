import 'package:flutter/material.dart';
import '../objects_widgets/user_info.dart';
import '../objects_widgets/app_card_one.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<UserInfo> users = [
    UserInfo(name: 'Wang Yi Lin', date: '12', month: '12', year: '1999'),
    UserInfo(name: 'Zheng Zong Qi', date: '07', month: '15', year: '2000'),
    UserInfo(name: 'Bookman', date: '01', month: '01', year: '2001'),
  ];



  int counter;

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
          children: users.map((user) {
            counter = counter + 1;
            return AppCardOne(user: user, cardId: counter);
          }).toList(),
        ),
      ),

      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/date_set_screen');
          },
          backgroundColor:Color.fromARGB(255, 229, 233, 240),
          child: Icon(
            Icons.add,
            color: Color.fromARGB(255, 59, 66, 82),
          )
      ),
    );
  }
}