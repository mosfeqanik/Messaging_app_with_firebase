import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:messaging_app/views/screens/RegisterScreen.dart';
import 'package:messaging_app/views/screens/LoginScreen.dart';
import 'common_widgets/round_button.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation animatedValue;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
    animationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
      // upperBound: 100,
      // lowerBound: 10
    );

    animatedValue = ColorTween(begin: Colors.blueGrey, end: Colors.white70)
        .animate(animationController);
    // //for animation small to bigger
    // animatedValue =
    //     CurvedAnimation(parent: animationController, curve: Curves.ease);
    animationController.forward();
    //
    // animatedValue.addStatusListener((status) {
    //   if (status == AnimationStatus.completed){
    //     animationController.reverse(from: 1);
    //   }else {
    //     if(status == AnimationStatus.dismissed){
    //     animationController.forward();
    //   }
    //   }
    // });
    // animationController.addListener(() {
    //   setState(() {
    //     animationController.value;
    //     // print(animationController.value);
    //   });
    // });
  }

  @override
  void dispose() {
    super.dispose();

    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:
            // Colors.white.withOpacity(opacityAnimationController.value),
            // Colors.white,
        animatedValue.value,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            //flash message Row
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: 'dash',
                    child: Container(
                      child: Image.asset('assets/images/logo.jpg'),
                      height: 60,
                    ),
                  ),
                  AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        'Flash Msg',
                        textStyle: const TextStyle(
                          fontSize: 32.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                        ),
                        speed: const Duration(milliseconds: 500),
                      ),
                    ],

                    totalRepeatCount: 4,
                    pause: const Duration(milliseconds: 500),
                    displayFullTextOnTap: true,
                    stopPauseOnTap: true,
                  )

                ],
              ),


              // Hero(
              //   tag: 'dash',
              //   child: Container(
              //     child: Image.asset('assets/images/logo.png'),
              //     height: 60,
              //   ),
              // ),
              // Row(
              //   mainAxisSize: MainAxisSize.min,
              //   children: <Widget>[
              //     const SizedBox(width: 20.0, height: 100.0),
              //     const Text(
              //       'Flash',
              //       style: TextStyle(
              //         fontSize: 20.0,
              //         color: Colors.black,
              //       ),
              //     ),
              //     const SizedBox(width: 20.0, height: 100.0),
              //     DefaultTextStyle(
              //       style: const TextStyle(
              //         fontSize: 30.0,
              //         fontFamily: 'Horizon',
              //         color: Colors.black,
              //       ),
              //       child: AnimatedTextKit(animatedTexts: [
              //         RotateAnimatedText('MSG'),
              //         RotateAnimatedText('CONNECTING'),
              //         RotateAnimatedText('EVERYONE'),
              //       ]),
              //     ),
              //   ],
              // ),
              SizedBox(height: 15),
              Container(
                child: RoundButton(
                  title: 'Log In',
                  buttonColor: Colors.lightBlueAccent,
                  onPressedFunction: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return LoginScreen();
                    }));
                  },
                ),
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
        ));
  }
}
