import 'package:flutter/material.dart';
import 'user_info.dart';

class AppCardOne extends StatelessWidget {

  UserInfo user;
  int cardId;

  AppCardOne({this.user, this.cardId});

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
                  Navigator.pushNamed(context, '/date_set_screen');
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(9)),
                  ),
                  primary: Color.fromARGB(
                      cardColor[cardId%2][0],
                      cardColor[cardId%2][1],
                      cardColor[cardId%2][2],
                      cardColor[cardId%2][3]),
                  ),
                child: Container(
                  padding: EdgeInsets.fromLTRB(8, 20, 8, 20),
                  child: Row(
                      children: <Widget>[
                        Expanded(
                          flex:1,
                          child: Text(
                            user.name,
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
                                  '阴历${user.month}月${user.date}日',
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
