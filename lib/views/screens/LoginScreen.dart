import 'package:flutter/material.dart';
import 'package:messaging_app/views/common_widgets/Round_TextField.dart';
import 'package:messaging_app/views/common_widgets/round_button.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailEditingController;
  TextEditingController _passwordEditingController;

  @override
  void initState() {
    super.initState();
    _emailEditingController = TextEditingController();
    _passwordEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: 'dash',
              child: Container(
                child: Image.asset('assets/images/logo.png'),
                height: 200,
              ),
            ),
            RoundTextField(
                textEditingController: _emailEditingController,
                isObscure: false,
                keyBoardTypeCheck: TextInputType.emailAddress,
                hintString: 'Enter your name'),
            SizedBox(
              height: 15,
            ),
            RoundTextField(
                textEditingController: _passwordEditingController,
                isObscure: true,
                keyBoardTypeCheck: TextInputType.text,
                hintString: 'Enter your Password'),
            RoundButton(
              title: 'Log in',
              buttonColor: Colors.deepOrange,
              onPressedFunction: () {
                print(_emailEditingController);
              },
            )
          ],
        ),
      ),
    );
  }
}
