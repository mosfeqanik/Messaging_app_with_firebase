import 'package:flutter/material.dart';

const KtextfieldStyle =InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(32.0)),
        borderSide: BorderSide(
            color: Colors.lightBlueAccent, width: 1.0)
    ),
    focusedBorder:OutlineInputBorder(
        borderSide: BorderSide(color: Colors.lightGreenAccent,width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(32.0))
    ),
    hintText: 'Enter A Value',
    hintStyle: TextStyle(
        color: Colors.grey
    )
);
const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);
const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 20.0,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);