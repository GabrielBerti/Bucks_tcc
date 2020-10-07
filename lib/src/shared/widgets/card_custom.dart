import 'package:flutter/material.dart';

class CardCustom extends StatelessWidget {
  final Widget widget;
  final Color color;
  final double borderRadius;
  final double padding;

  const CardCustom(
      {Key key,
      this.widget,
      this.color = Colors.white,
      this.borderRadius = 0.0,
      this.padding = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius)),
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
      child: Container(
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(color: color),
        child: widget,
      ),
    );
  }
}
