import 'package:flutter/material.dart';

class CardCustom<T> extends StatefulWidget {
  final Widget widget;
  final Color color;
  final T model;
  final double borderRadius;
  final double padding;

  const CardCustom(
      {Key key,
      this.widget,
      this.color = Colors.white,
      this.model,
      this.borderRadius = 0.0,
      this.padding = 0})
      : super(key: key);

  @override
  _CardListState createState() => _CardListState<T>();
}

class _CardListState<T> extends State<CardCustom<T>> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius)),
      elevation: 8.0,
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
      child: Container(
        padding: EdgeInsets.all(widget.padding),
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
        child: widget.widget == null ? Container() : widget.widget,
      ),
    );
  }
}
