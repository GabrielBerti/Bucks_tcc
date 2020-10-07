import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String hint;
  final Function validator;
  final Function onSaved;
  final bool password;
  final double fontsize;
  Icon icon;

  AppText(this.hint, this.icon,
      {this.validator,
      this.onSaved,
      this.password = false,
      this.fontsize = 18});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: TextAlign.center,
      validator: this.validator,
      onSaved: this.onSaved,
      obscureText: password,
      keyboardType: TextInputType.text,
      style: TextStyle(
        color: Colors.blueAccent,
        fontSize: this.fontsize,
      ),
      decoration: InputDecoration(
          prefixIcon: icon,
          fillColor: Colors.white,
          filled: true,
          labelStyle: TextStyle(
              color: Colors.blueAccent,
              fontSize: this.fontsize,
              fontWeight: FontWeight.bold),
          hintText: this.hint,
          hintStyle: TextStyle(
            color: Colors.blueAccent,
            fontSize: this.fontsize,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          errorStyle: TextStyle(fontSize: this.fontsize)),
    );
  }
}
