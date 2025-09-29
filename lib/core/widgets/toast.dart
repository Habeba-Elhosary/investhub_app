import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast({String? message, Color? bg}) {
  Fluttertoast.showToast(
    gravity: ToastGravity.TOP,
    backgroundColor: bg ?? Colors.black,
    textColor: Colors.white,
    msg: message.toString(),
    toastLength: Toast.LENGTH_LONG,
    timeInSecForIosWeb: 2,
  );
}

void showErrorToast(String message) {
  showToast(message: message, bg: Colors.red);
}

void showSucessToast(String message) {
  showToast(message: message, bg: Colors.green);
}
