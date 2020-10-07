import 'package:bucks/src/pages/item/item_controller.dart';
import 'package:bucks/src/pages/item/item_list/item_list_controller.dart';
import 'package:bucks/src/pages/item_unmed/item_unmed_list/item_unmed_list_controller.dart';
import 'package:bucks/src/pages/movto_estoque/movto_estoque_tipo/movto_estoque_tipo_list/movto_estoque_tipo_list_controller.dart';
import 'package:bucks/src/shared/widgets/button.dart';
import 'package:bucks/src/shared/widgets/flat_button_app.dart';
import 'package:bucks/src/shared/widgets/snackbar_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../movto_estoque_tipo_controller.dart';

class Buttons extends StatefulWidget {
  final MovtoEstoqueTipoController store;
  final MovtoEstoqueTipoListController storeTipoMovtoEstoqueList;

  Buttons({
    Key key,
    @required this.store,
    @required this.storeTipoMovtoEstoqueList,
    BuildContext context,
  }) : super(key: key);

  @override
  _Buttons createState() => _Buttons();
}

class _Buttons extends State<Buttons> {
  MovtoEstoqueTipoController get store => widget.store;
  MovtoEstoqueTipoListController get storeTipoMovtoEstoqueList =>
      widget.storeTipoMovtoEstoqueList;

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
    if (store.tecDescr.text == "") {
      snackbarError(
          context: context, msg: "Informe a descrição do tipo de movimento !");
      return;
    }

    if (store.tecCdTipoMovto.text == "") {
      snackbarError(
          context: context,
          msg: "Informe se o movimento é de entrada ou saída !");
      return;
    }

    if (store.tecCdTipoMovto.text != 's' &&
        store.tecCdTipoMovto.text != 'S' &&
        store.tecCdTipoMovto.text != 'e' &&
        store.tecCdTipoMovto.text != 'E') {
      snackbarError(context: context, msg: "Tipo de movimento inválido !");
      return;
    }

    store.tecCdTipoMovto.text = store.tecCdTipoMovto.text.toUpperCase();

    store.salvar(
        store: store, storeMovtoEstoqueTipoList: storeTipoMovtoEstoqueList);
    snackbarSucces(
        context: context,
        msg: "Tipo de movimento inserido com sucesso !",
        title: "Tipo de movimento Inserido");
  }
}
