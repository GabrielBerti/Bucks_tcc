import 'package:flutter/material.dart';

class ListileCustom extends StatelessWidget {
  final Widget title;
  final Widget subTitle;
  final Widget trailing;
  final Icon iconLeading;

  const ListileCustom(
      {Key key, this.title, this.subTitle, this.trailing, this.iconLeading})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
        leading: Container(
          padding: EdgeInsets.only(right: 12.0),
          decoration: BoxDecoration(
              border:
                  Border(right: BorderSide(width: 1.0, color: Colors.black12))),
          child: iconLeading ?? Icon(Icons.list, color: Colors.black),
        ),
        title: title ?? Container(),
        subtitle: subTitle ?? Container(),
        trailing: trailing ?? null);
  }
}
