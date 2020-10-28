import 'package:Haritkranti/Screens/welcomeScreens/ScrrenButtons/BT1.dart';
import 'package:Haritkranti/Screens/welcomeScreens/ScrrenButtons/BT4.dart';
import 'package:Haritkranti/Screens/welcomeScreens/ScrrenButtons/bt6.dart';
import 'package:flutter/material.dart';

class WelcomeScreen7 extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}




 _buildInput() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10.5),
          child: Icon(
            Icons.article,
            color: Colors.white,
          ),
        ),
        // Padding(
          // padding: const EdgeInsets.all(8.0),
          // child: Text('+91 ', style: TextStyle(fontSize: 30.0)),
        // ),
        Expanded(
          flex: 1,
          child: TextFormField(
            // maxLength: 10,
            keyboardType: TextInputType.name,
            autocorrect: false,
            decoration: InputDecoration(
              hintText: 'गेहूँ',
            ),
          ),
        ),
      ],
    );
  }
class _WelcomeScreenState extends State<WelcomeScreen7> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/Background-02.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // StatusBarWidgetWeather(),
            
              Text(
                "कौन सी फसल लगाना चाह्ते है",
                style: TextStyle(color: Colors.white, fontSize: 28.0),
              ),
               SizedBox(
                height: 40.0,
              ),
                
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                    height: 130.0,
                    width: MediaQuery.of(context).size.width,
                    decoration: new BoxDecoration(
                        color: Colors.green,
                       
                        ),
                        child:_buildInput()
                        
                        ),
              ),
            
             
            BT6()
                  ],
          ),
        ),
        
      ),
    );
      
  }
}