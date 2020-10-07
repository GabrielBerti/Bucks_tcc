import 'package:bucks/src/pages/item/item_controller.dart';
import 'package:bucks/src/pages/item/item_list/item_list_controller.dart';
import 'package:bucks/src/shared/widgets/flat_button_app.dart';
import 'package:bucks/src/shared/widgets/snackbar_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../shared/widgets/button.dart';
import '../item_tipo_controller.dart';
import '../item_tipo_list/item_tipo_list_controller.dart';

class Buttons extends StatefulWidget {
  final ItemTipoController store;
  final ItemTipoListController storeItemTipoList;

  Buttons(
      {Key key,
      @required this.store,
      @required this.storeItemTipoList,
      BuildContext context})
      : super(key: key);

  @override
  _Buttons createState() => _Buttons();
}

class _Buttons extends State<Buttons> {
  ItemTipoController get store => widget.store;
  ItemTipoListController get storeItemTipoList => widget.storeItemTipoList;

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
    if (store.descr.text == "") {
      snackbarError(
          context: context, msg: "Informe a descrição do tipo de item !");
      return;
    }

    store.salvarItemTipo(store: store, storeItemTipoList: storeItemTipoList);
    snackbarSucces(
        context: context,
        msg: "Item tipo inserido com sucesso !",
        title: "Item tipo Inserido");
  }
}
