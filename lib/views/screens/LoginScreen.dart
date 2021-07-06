import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messaging_app/views/common_widgets/Round_TextField.dart';
import 'package:messaging_app/views/common_widgets/round_button.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'ChatScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailEditingController;
  TextEditingController _passwordEditingController;
  final _auth = FirebaseAuth.instance;
  bool showSpinner;

  @override
  void initState() {
    showSpinner = false;
    _emailEditingController = TextEditingController();
    _passwordEditingController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
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
                  hintString: 'Enter your Email'),
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
                onPressedFunction: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    final user = _auth.signInWithEmailAndPassword(
                        email: _emailEditingController.text,
                        password: _passwordEditingController.text);
                    if (user != null) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ChatScreen();
                      }));
                    }
                    setState(() {
                      showSpinner = false;
                    });
                  } catch (error) {
                    print(error);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
