import 'package:bucks/src/pages/tipo_producao/tipo_producao_list/tipo_producao_list_controller.dart';
import 'package:bucks/src/shared/widgets/snackbar_custom.dart';
import 'package:flutter/material.dart';

import '../../../shared/widgets/button.dart';
import '../tipo_producao_controller.dart';

class Buttons extends StatefulWidget {
  final TipoProducaoController store;
  final TipoProducaoListController storeTipoProducaoList;

  Buttons(
      {Key key,
      @required this.store,
      @required this.storeTipoProducaoList,
      BuildContext context})
      : super(key: key);

  @override
  _Buttons createState() => _Buttons();
}

class _Buttons extends State<Buttons> {
  TipoProducaoController get store => widget.store;
  TipoProducaoListController get storeTipoProducaoList =>
      widget.storeTipoProducaoList;

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

    store.salvarTipoProducao(
        store: store, storeTipoProducaoList: storeTipoProducaoList);
    snackbarSucces(
        context: context,
        msg: "Item tipo inserido com sucesso !",
        title: "Item tipo Inserido");
  }
}
