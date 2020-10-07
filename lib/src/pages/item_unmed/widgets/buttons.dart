import 'package:bucks/src/pages/item/item_controller.dart';
import 'package:bucks/src/pages/item/item_list/item_list_controller.dart';
import 'package:bucks/src/pages/item_unmed/item_unmed_list/item_unmed_list_controller.dart';
import 'package:bucks/src/shared/widgets/flat_button_app.dart';
import 'package:bucks/src/shared/widgets/snackbar_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../shared/widgets/button.dart';
import '../item_unmed_controller.dart';

class Buttons extends StatefulWidget {
  final ItemUnmedController store;
  final ItemUnmedListController storeItemUnMedList;

  Buttons({
    Key key,
    @required this.store,
    @required this.storeItemUnMedList,
    BuildContext context,
  }) : super(key: key);

  @override
  _Buttons createState() => _Buttons();
}

class _Buttons extends State<Buttons> {
  ItemUnmedController get store => widget.store;
  ItemUnmedListController get storeItemUnMedList => widget.storeItemUnMedList;

  get onPressed => null;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
            ),
            margin: EdgeInsets.only(top: 20),
            child: Container(
              width: 100,
              child: AppButton(
                "Salvar",
                onPressedButtons,
              ),
            ),
          ),
        ),
      ],
    );
  }

  onPressedButtons() async {
    if (store.id.text == "") {
      snackbarError(
          context: context, msg: "Informe o código da unidade de medida !");
      return;
    }

    if (store.descr.text == "") {
      snackbarError(
          context: context, msg: "Informe a descrição da unidade de medida !");
      return;
    }

    store.id.text = store.id.text.toUpperCase();

    store.salvar(store: store, storeItemUnmedList: storeItemUnMedList);
    snackbarSucces(
        context: context,
        msg: "Un. medida inserida com sucesso !",
        title: "Un. medida Inserida");
  }
}
