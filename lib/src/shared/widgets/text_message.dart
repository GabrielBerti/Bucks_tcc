import 'package:flutter/material.dart';

class TextMessage extends StatelessWidget {
  final String msg;
  final double fontSize;
  final FontWeight fontWeight;
  final Function onRefresh;
  final Color color;

  TextMessage(this.msg,
      {this.onRefresh,
      this.fontSize = 16.0,
      this.fontWeight = FontWeight.normal,
      this.color = Colors.grey});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onRefresh,
      child: Container(
        alignment: Alignment(0.0, 0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(msg,
                style: TextStyle(
                    color: color, fontSize: fontSize, fontWeight: fontWeight),
                textAlign: TextAlign.center),
            SizedBox(
              height: 12,
            )
          ],
        ),
      ),
    );
  }
}
