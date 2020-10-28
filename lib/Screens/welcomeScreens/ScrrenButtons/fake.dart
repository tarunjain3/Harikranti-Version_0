import 'package:Haritkranti/Screens/welcomeScreens/ScrrenButtons/Screen3.dart';
import 'package:Haritkranti/Screens/welcomeScreens/ScrrenButtons/screen2.dart';
import 'package:flutter/material.dart';

class BTF extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(color: Colors.transparent)),
                    color: Colors.transparent,
                    textColor: Colors.white,
                    padding: EdgeInsets.all(8.0),
                    onPressed: () {
                      //     setState(() {
                      //   Localization.load(Locale('hi', 'IN'));
                      // });
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => WelcomeScreen2()));
                    },
                    child: Text(
                      "".toUpperCase(),
                      style: TextStyle(
                        fontSize: 24.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                    height: 20.0,
                  ),
                  FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(color: Colors.transparent)),
                    color: Colors.transparent,
                    textColor: Colors.white,
                    padding: EdgeInsets.all(8.0),
                    onPressed: () {
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => WelcomeScreen3()));
                    },
                    child: Text(
                      "".toUpperCase(),
                      style: TextStyle(
                        fontSize: 24.0,
                      ),
                    ),
                  ),
                ],
              ),
      
    );
  }
}