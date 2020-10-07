import 'package:flutter/material.dart';

class ScaffoldListCustom extends StatefulWidget {
  final String title;
  final String titleList;
  final List<Widget> listWidget;
  final Icon iconAppBar;
  final Color colorTitleList;
  final Color colorTextList;
  final Function onPressed;

  const ScaffoldListCustom(
      {Key key,
      this.title = '',
      this.listWidget,
      this.iconAppBar,
      this.titleList = '',
      this.colorTitleList,
      this.colorTextList,
      this.onPressed})
      : super(key: key);
  @override
  _ScaffoldCustomState createState() => _ScaffoldCustomState();
}

class _ScaffoldCustomState extends State<ScaffoldListCustom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: widget.onPressed,
          )
        ],
      ),
      body: ListView(
        // mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            color: widget.colorTitleList,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Text(
              widget.titleList,
              style: TextStyle(
                fontSize: 24,
                color: widget.colorTextList,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Column(
            children: widget.listWidget,
          ),
        ],
      ),
    );
  }
}
