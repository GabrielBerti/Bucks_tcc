import 'package:flutter/material.dart';

class CorDeFundo {
  static corFundoPadrao() {
    List<Color> colors = [Colors.blue, Colors.black];
    return colors;
  }

  static boxDecorationPadrao() => BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: LinearGradient(
          colors: [Colors.blue, Colors.black],
          begin: FractionalOffset.topCenter,
          end: FractionalOffset.bottomCenter,
        ),
      );

  static ContainerDecorationPadrao(
          {double height = 30,
          double fontSize = 20,
          Color corLetra = Colors.white,
          String text = '',
          FontWeight fontWeight = FontWeight.normal,
          Alignment alignment = Alignment.center}) =>
      Container(
        decoration: CorDeFundo.boxDecorationPadrao(),
        alignment: alignment,
        width: double.infinity,
        height: height,
        child: Text(
          text,
          style: TextStyle(
              fontSize: fontSize, color: corLetra, fontWeight: fontWeight),
        ),
      );
}
