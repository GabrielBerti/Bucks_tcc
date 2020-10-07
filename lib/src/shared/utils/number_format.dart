import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

numberFormatThousand({@required num value}) {
  var format = NumberFormat("###,###.##", "pt_br");
  return format.format(value);
}
