import 'package:flutter/material.dart';

String validaQtdeCaracteres({@required String value, @required int size}) {
  var newValue = value;
  if (value != null && value.length > size ) {
    var text = value.substring(0, size);
    newValue = '$text ...';
  }

  return newValue;
}
