import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messaging_app/views/common_widgets/Round_TextField.dart';
import 'package:messaging_app/views/common_widgets/round_button.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'ChatScreen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _auth = FirebaseAuth.instance;
  TextEditingController _emailEditingController;
  TextEditingController _passwordEditingController;
  bool showSpinner;

  @override
  void initState() {
    _emailEditingController = TextEditingController();
    _passwordEditingController = TextEditingController();
    showSpinner = false;
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
                  child: Image.asset('assets/images/logo.jpg'),
                  height: 200,
                ),
              ),
              RoundTextField(
                  textEditingController: _emailEditingController,
                  isObscure: false,
                  keyBoardTypeCheck: TextInputType.emailAddress,
                  hintString: 'Enter Your Email'),
              SizedBox(
                height: 15,
              ),
              RoundTextField(
                  textEditingController: _passwordEditingController,
                  isObscure: true,
                  keyBoardTypeCheck: TextInputType.text,
                  hintString: 'Enter your Password'),
              RoundButton(
                title: 'Sign Up',
                buttonColor: Colors.deepOrange,
                onPressedFunction: () {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    final newUser = _auth.createUserWithEmailAndPassword(
                        email: _emailEditingController.text,
                        password: _passwordEditingController.text);
                    if(newUser != "" && newUser != null){
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return ChatScreen();
                      }));
                    }
                  } catch (error) {
                    print(error.toString());
                  }
                  setState(() {
                    showSpinner = false;
                  });
                  // print(_emailEditingController.text);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
