import 'package:bucks/src/shared/widgets/snackbar_custom.dart';
import 'package:flutter/material.dart';

import '../../../shared/widgets/button.dart';
import '../movto_estoque_list_controller.dart';

class Buttons extends StatefulWidget {
  final dynamic store;
  final MovtoEstoqueListController storeMovtoEstoqueList;

  Buttons(
      {Key key,
      @required this.store,
      @required this.storeMovtoEstoqueList,
      BuildContext context})
      : super(key: key);

  @override
  _Buttons createState() => _Buttons();
}

class _Buttons extends State<Buttons> {
  dynamic get store => widget.store;
  MovtoEstoqueListController get storeMovtoEstoqueList =>
      widget.storeMovtoEstoqueList;

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
    String msgErroDropDowns = await storeMovtoEstoqueList.validateDropDowns();

    if (storeMovtoEstoqueList.lovMovtoEstoqueTipoSelected.cdTipoMovto == 'S' &&
        store.vlUnit.text != '') {
      snackbarError(
          context: context,
          msg:
              "Valor unitário não deve ser preenchidos para movimentos de saída !");
      return;
    }

    if ((msgErroDropDowns != '' ||
            store.dt.text == '' ||
            store.qtd.text == '') &&
        (store.vlUnit.text == '' &&
            storeMovtoEstoqueList.lovMovtoEstoqueTipoSelected.cdTipoMovto ==
                'S')) {
      snackbarError(
          context: context, msg: "Existem campos que não estão preenchidos !");
      return;
    }

    if (store.vlUnit.text == '' &&
        storeMovtoEstoqueList.lovMovtoEstoqueTipoSelected.cdTipoMovto == 'E') {
      snackbarError(
          context: context, msg: "Valor Unitário deve ser informado!");
      return;
    }

    if (storeMovtoEstoqueList.lovMovtoEstoqueTipoSelected.cdTipoMovto == 'E') {
      if (double.parse(store.vlUnit.text) < 1) {
        snackbarError(
            context: context, msg: "Valor Unitário não pode ser menor que 1!");
        return;
      }
    }

    if (storeMovtoEstoqueList.lovMovtoEstoqueTipoSelected.cdTipoMovto == 'S') {
      await storeMovtoEstoqueList.verificaQtdEstoque(
          idItem: storeMovtoEstoqueList.lovItemEstoqueSelected.fkItemId,
          qtdPedida: double.parse(store.qtd.text),
          movtoEstoqueListController: storeMovtoEstoqueList);

      if (storeMovtoEstoqueList.possuiQtdEstoque == false) {
        snackbarError(
            context: context,
            msg:
                "Item: ${storeMovtoEstoqueList.lovItemEstoqueSelected.fkItemDescr}, não possui esta quantidade disponível no estoque !");

        return;
      }
    }

    store.salvar(store: store, storeMovtoEstoqueList: storeMovtoEstoqueList);
    snackbarSucces(
        context: context,
        msg: "Movto Estoque inserido com sucesso !",
        title: "Movto Estoque Inserido");
  }
}
