import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
void CommonToast(String text) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,     // Duration for the toast: LENGTH_SHORT or LENGTH_LONG
      gravity: ToastGravity.BOTTOM,        // Position of the toast: TOP, CENTER, or BOTTOM
      backgroundColor: Colors.black54,     // Background color of the toast
      textColor: Colors.white,             // Text color of the toast
      fontSize: 16.0                       // Font size of the message text
  );
}
