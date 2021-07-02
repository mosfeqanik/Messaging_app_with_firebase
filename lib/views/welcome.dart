import 'package:flutter/material.dart';
import 'package:messaging_app/views/screens/RegisterScreen.dart';
import 'package:messaging_app/views/screens/loginscreen.dart';
import 'common_widgets/round_button.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          //flash message Row
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Image.asset('assets/images/logo.png'),
                  height: 60,
                ),
                Text(
                  'Flash Msg',
                  style: TextStyle(
                      fontSize: 45.0,
                      fontWeight: FontWeight.w900,
                      color: Colors.black54),
                )
              ],
            ),
            SizedBox(height: 15),
            RoundButton(
              title: 'Log In',
              buttonColor: Colors.lightBlueAccent,
              onPressedFunction: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return LoginScreen();
                }));
              },
            ),
            RoundButton(
              title: 'Register',
              buttonColor: Colors.deepOrange,
              onPressedFunction: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return RegisterScreen();
                }));
              },
            )
          ],
        ),
      )
    );
  }
}