import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messaging_app/constants/Constants.dart';

class RoundTextField extends StatelessWidget {
  final String hintString;
  RoundTextField({this.hintString});
  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: Colors.black),
      textAlign: TextAlign.center,
      decoration: KtextfieldStyle.copyWith(
        hintText: hintString,
      ),
    );
  }
}
