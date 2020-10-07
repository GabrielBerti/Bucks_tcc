import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

alertSimNao(BuildContext context, String title, String message,
        Function function) =>
    Alert(
      context: context,
      //type: AlertType.info,
      title: title,
      desc: message,
      buttons: [
        DialogButton(
          child: Text(
            "SIM",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: function,
          color: Colors.green,
        ),
        DialogButton(
          child: Text(
            "NÃO",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Colors.red,
        )
      ],
    ).show();

alert(BuildContext context, String title, String msg, {Function callback}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(msg),
        actions: <Widget>[
          FlatButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.pop(context);
              if (callback != null) {
                callback();
              }
            },
          )
        ],
      );
    },
  );
}
