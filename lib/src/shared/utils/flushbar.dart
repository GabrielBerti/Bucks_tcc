import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

snackbarBasic(
    {@required BuildContext context,
    @required String title,
    @required String message,
    Color backgroundColor = const Color(0xFF303030)}) {
  return Flushbar(
    title: title,
    message: message,
    duration: Duration(seconds: 3),
    backgroundColor: backgroundColor,
  )..show(context);
}

snackbarLeftIndicator(
    {@required BuildContext context,
    Icon icon,
    String title = "",
    @required String message,
    Color backgroundColor,
    int durantionSeconds = 3}) {
  icon = icon ?? Icon(Icons.info_outline, size: 28.0, color: Colors.blue[300]);
  return Flushbar(
    title: title,
    message: message,
    icon: icon,
    duration: Duration(seconds: durantionSeconds),
    leftBarIndicatorColor: backgroundColor ?? Colors.blue[300],
  )..show(context);
}

snackbarLeftIndicatorWithoutDuration(
    {@required BuildContext context,
    Icon icon,
    String title = "",
    @required String message,
    Color backgroundColor}) {
  icon = icon ?? Icon(Icons.info_outline, size: 28.0, color: Colors.blue[300]);
  return Flushbar(
    title: title,
    message: message,
    icon: icon,
    leftBarIndicatorColor: backgroundColor ?? Colors.blue[300],
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    mainButton: FlatButton(
      child: Text(
        "X",
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () => Navigator.pop(context),
    ),
  )..show(context);
}
