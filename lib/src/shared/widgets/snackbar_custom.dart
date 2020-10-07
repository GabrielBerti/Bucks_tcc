import 'package:bucks/src/shared/utils/flushbar.dart';
import 'package:flutter/material.dart';

snackbarSucces(
        {@required BuildContext context,
        @required String title,
        @required String msg}) =>
    snackbarLeftIndicator(
        context: context,
        icon: Icon(
          Icons.check,
          color: Colors.green,
        ),
        backgroundColor: Colors.green,
        title: title,
        message: msg,
        durantionSeconds: 4);

snackbarError({@required BuildContext context, @required String msg}) =>
    snackbarLeftIndicator(
        context: context,
        icon: Icon(
          Icons.error,
          color: Colors.red,
        ),
        backgroundColor: Colors.red,
        title: "Erro",
        message: msg,
        durantionSeconds: 4);

snackbarInfo({@required BuildContext context, @required String msg}) =>
    snackbarLeftIndicator(
        context: context,
        icon: Icon(
          Icons.info,
          color: Colors.blue,
        ),
        backgroundColor: Colors.blue,
        title: "Info",
        message: msg,
        durantionSeconds: 5);

snackbarInfoWithoutDuration(
        {@required BuildContext context, @required String msg}) =>
    snackbarLeftIndicatorWithoutDuration(
      context: context,
      icon: Icon(
        Icons.info,
        color: Colors.blue,
      ),
      backgroundColor: Colors.blue,
      title: "Info",
      message: msg,
    );
