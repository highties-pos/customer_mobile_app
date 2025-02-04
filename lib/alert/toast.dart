import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(message, [success = true]) => Fluttertoast.showToast(
      msg: message,
      fontSize: 18,
      backgroundColor: success ? Colors.green : Colors.red,
      gravity: ToastGravity.TOP,
    );


