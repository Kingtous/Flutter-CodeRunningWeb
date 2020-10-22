import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtils {
  static bool isOpen = true;

  static setEnable(bool b) {
    isOpen = b;
  }

  static show(s) {
    if (isOpen) {
      Fluttertoast.showToast(
          msg: s,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          fontSize: 13.5);
    }
  }
}
