import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// Show toast once some task is completed by app
void showToast({
  String? message,
}) {
  Fluttertoast.showToast(
    msg: message ?? "Coming soon..",
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.black,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
