import 'package:flutter/material.dart';

class ListileCustom2<T> extends StatelessWidget {
  final T model;
  final List<Widget> listWidgetTitle;
  final List<Widget> listWidgetSubTitle;
  final Function onTap;
  final double horizontal;
  final double vertical;

  const ListileCustom2(
      {Key key,
      this.model,
      this.listWidgetTitle,
      this.listWidgetSubTitle,
      this.onTap,
      this.horizontal = 20.0,
      this.vertical = 10.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        contentPadding:
            EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
        leading: Container(
          padding: EdgeInsets.only(right: 12.0),
          decoration: new BoxDecoration(
              border: new Border(
                  right: new BorderSide(width: 1.0, color: Colors.white24))),
          child: Icon(Icons.list, color: Colors.white),
        ),
        title: Row(children: listWidgetTitle),
        subtitle: Row(children: listWidgetSubTitle),
        trailing:
            Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
        onTap: onTap);
  }
}
