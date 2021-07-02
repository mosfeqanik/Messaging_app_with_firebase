import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final Color buttoncolor ;
  final String title  ;
  final Function OnpressedFunction  ;

  RoundButton ({@required this.OnpressedFunction,this.buttoncolor,this.title});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5,
        color: buttoncolor,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: OnpressedFunction,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
            ),),
        ),
      ),
    );
  }
}
