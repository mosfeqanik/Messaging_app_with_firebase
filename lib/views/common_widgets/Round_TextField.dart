import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messaging_app/constants/Constants.dart';

class RoundTextField extends StatelessWidget {
  final String hintString;
  final bool isObscure;
  final TextInputType keyBoardTypeCheck;
  final TextEditingController textEditingController;

  RoundTextField(
      { this.hintString, this.isObscure, this.keyBoardTypeCheck, @required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyBoardTypeCheck,
      obscureText: isObscure,
      controller:textEditingController,
      style: TextStyle(color: Colors.black),
      textAlign: TextAlign.center,
      decoration: KtextfieldStyle.copyWith(
        hintText: hintString,
      ),
    );
  }
}
