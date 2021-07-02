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