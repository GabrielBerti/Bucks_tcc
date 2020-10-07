import 'package:flutter/material.dart';

class TituloLista extends StatelessWidget {

  String texto;

  TituloLista({this.texto});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        gradient: LinearGradient(
          colors: [Colors.orange, Colors.red],
          begin: FractionalOffset.topCenter,
          end: FractionalOffset.bottomCenter,
        ),
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(left: 5.0),
          child: Text(
            texto,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}