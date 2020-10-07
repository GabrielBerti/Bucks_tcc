import 'package:bucks/src/shared/utils/colors.dart';
import 'package:flutter/material.dart';

import 'buttons.dart';
import 'card_custom.dart';


class CardConfiguracao extends StatefulWidget {
  final dynamic store;

  const CardConfiguracao({Key key, @required this.store}) : super(key: key);

  @override
  _CardConfiguracao createState() => _CardConfiguracao();
}

class _CardConfiguracao extends State<CardConfiguracao> {
  CardCustom listaUnidade() {
    List<Widget> list = List();

    list.add(CorDeFundo.ContainerDecorationPadrao(
        text: 'Unidade', fontSize: 24, fontWeight: FontWeight.bold));
    list.add(SizedBox(height: 10));
    // list.add(DropdownFindUnidade(
    //   store: widget.store,
    // ));

    return CardCustom(
      padding: 20,
      borderRadius: 15.0,
      widget: Column(
        children: list,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return listaUnidade();
  }
}

class DropdownFindUnidade {
}

class CardButton extends StatefulWidget {
  final dynamic store;

  const CardButton({Key key, @required this.store}) : super(key: key);

  @override
  _CardButton createState() => _CardButton();
}

class _CardButton extends State<CardButton> {
  CardCustom buttons() {
    List<Widget> list = List();

    list.add(ButtonsConfiguracao(store: widget.store));

    return CardCustom(
      padding: 20,
      borderRadius: 15.0,
      widget: Column(
        children: list,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buttons();
  }
}
