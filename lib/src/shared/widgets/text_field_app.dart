import 'package:flutter/material.dart';

class TextFieldApp extends StatelessWidget {
  final TextEditingController controller;
  final Icon icone;
  final bool password;
  final TextInputType keyBoardType;
  final TextAlign textAlign;
  final Function validator;
  final Function onChange;
  final String text;
  final String initialValue;
  final bool pEnabled;

  TextFieldApp(
      {Key key,
      this.controller,
      this.icone,
      this.password = false,
      this.keyBoardType = TextInputType.text,
      this.textAlign = TextAlign.start,
      this.validator,
      this.text,
      this.onChange,
      this.initialValue,
      this.pEnabled = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 24),
      child: TextFormField(
        //initialValue: initialValue,
        onChanged: onChange,
        controller: controller,
        obscureText: password,
        keyboardType: keyBoardType,
        textAlign: textAlign,
        validator: validator,
        style: TextStyle(
          color: Colors.black,
        ),
        decoration: _inputDecoration(),
        enabled: pEnabled,
      ),
    );
  }

  _inputDecoration() {
    return InputDecoration(
      prefixIcon: icone,
      hintText: text,
      hintStyle: TextStyle(
        color: Colors.grey,
        fontSize: 13,
        fontWeight: FontWeight.bold,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(22),
      ),
    );
  }
}
