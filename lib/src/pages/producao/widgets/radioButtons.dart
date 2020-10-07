import 'package:bucks/src/pages/producao/producao_list/producao_list_controller.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class RadioButtonEntrSaida extends StatefulWidget {
  final ProducaoListController store;

  const RadioButtonEntrSaida({Key key, @required this.store}) : super(key: key);

  @override
  _RadioButtonEntrSaida createState() => _RadioButtonEntrSaida();
}

class _RadioButtonEntrSaida extends State<RadioButtonEntrSaida> {
  ProducaoListController get store => widget.store;
  int radioValue;

  void handleRadioValueChange(int value) {
    setState(() {
      radioValue = value;

      switch (radioValue) {
        case 0:
          store.tipoProducaoItem = 'E';
          //store.filtraFrota(store.filtroCaminhaoTrator);
          break;
        case 1:
          store.tipoProducaoItem = 'S';
          //store.filtraFrota(store.filtroCaminhaoTrator);
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Radio(
          autofocus: true,
          value: 0,
          groupValue: radioValue,
          onChanged: handleRadioValueChange,
        ),
        new Text('E'),
        new Radio(
          value: 1,
          groupValue: radioValue,
          onChanged: handleRadioValueChange,
        ),
        new Text('S'),
      ],
    );
  }
}
