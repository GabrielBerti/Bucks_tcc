import 'package:bucks/src/shared/theme/light.theme.dart';
import 'package:flutter/material.dart';

class FlatButtonApp extends StatelessWidget {
  final IconData icone;
  final String label;
  final Function onPressed;
  final String action;

  FlatButtonApp({
    Key key,
    this.icone,
    this.label,
    this.onPressed,
    this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color cor1 = _getCor1(action, context);
    Color cor2 = _getCor2(action, context);
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [cor1, cor2],
            begin: FractionalOffset.centerLeft,
            end: FractionalOffset.centerRight,
          ),
          borderRadius: BorderRadius.circular(22)),
      child: icone != null
          ? _flatButtonIcon(icone, label, onPressed)
          : _flatButton(label, onPressed),
    );
  }

  _flatButtonIcon(icone, label, onPressed) {
    return FlatButton.icon(
      icon: Icon(
        icone,
        color: Colors.white,
      ),
      onPressed: onPressed,
      label: Center(
        child: Text(
          label,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  _flatButton(label, onPressed) {
    return FlatButton(
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
      onPressed: onPressed,
    );
  }

  Color _getCor1(action, context) {
    if (action == "confirmar") {
      return Colors.green[200];
    } else if (action == "excluir") {
      return Colors.red[200];
    }
    return lightTheme().primaryColor;
  }

  Color _getCor2(String action, context) {
    if (action == "confirmar") {
      return Colors.green[400];
    } else if (action == "excluir") {
      return Colors.red[400];
    }
    return lightTheme().accentColor;
  }
}
