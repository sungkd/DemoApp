import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

 const textInputDecoration =
  InputDecoration(
    labelStyle: TextStyle(
        color: Colors.white,
        letterSpacing: 1.2,
        fontSize: 15.0,
        fontWeight: FontWeight.bold
    ),
    filled: true,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(6.0)),
    ),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blueGrey, width: 2.0,)
    ),
  );

