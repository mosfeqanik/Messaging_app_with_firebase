import 'package:flutter/material.dart';
import 'package:messaging_app/views/common_widgets/Round_TextField.dart';
import 'package:messaging_app/views/common_widgets/round_button.dart';

class RegisterScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              child: Image.asset('assets/images/logo.png'),
              height: 200,
            ),
            RoundTextField(hintString: 'Enter your name'),
            SizedBox(height: 15,),
            RoundTextField(hintString: 'Enter your Password'),
            RoundButton(
              title: 'Sign Up',
              buttonColor: Colors.deepOrange,
              onPressedFunction: () {
                print('Sign Up is working');
              },
            )
          ],
        ),
      ),
    );
  }
}
