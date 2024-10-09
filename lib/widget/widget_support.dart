import 'dart:ui';

import 'package:flutter/material.dart';

class AppWidget {
  static TextStyle boldTextFieldStyle() {
    return TextStyle(
      fontSize: 20,
      color: Colors.black,
      fontFamily: "Poppins",
    );
  }

  static TextStyle headlineTextFieldStyle() {
    return TextStyle(
      fontSize: 25,
      color: Colors.black,
      fontFamily: "Poppins",
    );
  }
  static TextStyle lightTextFieldStyle() {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Colors.black45,
      fontFamily: "Poppins",
    );
  }
  static TextStyle semiboldTextFieldStyle() {
    return TextStyle(
      fontSize: 17,
      color: Colors.black,
      fontFamily: "Poppins",
    );
  }
}