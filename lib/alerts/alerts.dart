
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future alertTost(String message, {int seconds = 1}) {
  return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: seconds,
        backgroundColor: Color(0xff222222),
        textColor: Colors.white,
    );
}