import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback callback;
  final bool showProgress;
  final double fontSize;
  final Color color1;
  final Color color2;

  AppButton(this.text, this.callback,
      {this.showProgress = false,
      this.fontSize = 18,
      this.color1 = Colors.blue,
      this.color2 = Colors.black});

  @override
  Widget build(BuildContext context) {
    final backgroundColor1 = color1;
    final backgroundColor2 = color2;
    final textColor = Colors.white;

    return Container(
      width: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: LinearGradient(
          colors: [backgroundColor1, backgroundColor2],
          begin: FractionalOffset.topCenter,
          end: FractionalOffset.bottomCenter,
        ),
      ),
      child: FlatButton(
        child: showProgress
            ? Center(
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(textColor),
                ),
              )
            : Text(
                text,
                style: TextStyle(
                  fontSize: this.fontSize,
                  color: textColor,
                ),
              ),
        onPressed: callback,
      ),
    );
  }
}

class ButtonGreen extends StatelessWidget {
  final String text;
  final VoidCallback callback;
  final bool showProgress;
  final double fontSize;
  final Color color1;
  final Color color2;

  ButtonGreen(this.text, this.callback,
      {this.showProgress = false,
      this.fontSize = 18,
      this.color1 = Colors.green,
      this.color2 = Colors.black});

  @override
  Widget build(BuildContext context) {
    final backgroundColor1 = color1;
    final backgroundColor2 = color2;
    final textColor = Colors.white;

    return Container(
      width: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: LinearGradient(
          colors: [backgroundColor1, backgroundColor2],
          begin: FractionalOffset.topCenter,
          end: FractionalOffset.bottomCenter,
        ),
      ),
      child: FlatButton(
        child: showProgress
            ? Center(
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(textColor),
                ),
              )
            : Text(
                text,
                style: TextStyle(
                  fontSize: this.fontSize,
                  color: textColor,
                ),
              ),
        onPressed: callback,
      ),
    );
  }
}
