import 'package:bucks/src/classes/producao.dart';
import 'package:bucks/src/pages/item/item_controller.dart';
import 'package:bucks/src/pages/item/item_list/item_list_controller.dart';
import 'package:bucks/src/pages/producao/producao_list/producao_list_controller.dart';
import 'package:bucks/src/shared/widgets/flat_button_app.dart';
import 'package:bucks/src/shared/widgets/snackbar_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../shared/widgets/button.dart';

class ButtonsProducao extends StatefulWidget {
  final dynamic store;

  ButtonsProducao({Key key, @required this.store, BuildContext context})
      : super(key: key);

  @override
  _ButtonsProducao createState() => _ButtonsProducao();
}

class _ButtonsProducao extends State<ButtonsProducao> {
  dynamic get store => widget.store;

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
                "Salvar Produção",
                onPressedButtons,
              ),
            ),
          ),
        ),
      ],
    );
  }

  onPressedButtons() async {}
}

class ButtonsFinalizarProd extends StatefulWidget {
  final dynamic store;
  final ProducaoListController storeProducaoList;

  ButtonsFinalizarProd(
      {Key key,
      @required this.store,
      @required this.storeProducaoList,
      BuildContext context})
      : super(key: key);

  @override
  _ButtonsFinalizarProd createState() => _ButtonsFinalizarProd();
}

class _ButtonsFinalizarProd extends State<ButtonsFinalizarProd> {
  dynamic get store => widget.store;
  ProducaoListController get storeProducaoList => widget.storeProducaoList;

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
              child: ButtonGreen(
                "Baixar Produção",
                onPressedButtons,
              ),
            ),
          ),
        ),
      ],
    );
  }

  onPressedButtons() async {
    showAlertDialogBaixaProd(context);
  }

  showAlertDialogBaixaProd(
    BuildContext context,
    //ItemTipo itemTipo,
  ) {
    // configura o button
    Widget cancelButton = FlatButton(
      child: Text("Cancelar"),
      onPressed: () {
        Navigator.of(context).pop(false);
      },
    );
    Widget confirmButton = FlatButton(
      child: Text("Sim"),
      onPressed: () async {
        if (storeProducaoList.producaoItensDt.length == 0) {
          snackbarError(
              context: context, msg: "Nenhum item informado na produção !");
          return;
        }

        Navigator.of(context).pop(false);

        await store.baixarProducao(
            store: store, storeProducaoList: storeProducaoList);

        //Producao producao = Producao();
        //producao.id = storeProducaoList.producaoItensDt.;
        //await storeProducaoList.listarProducaoItem(producao);

        snackbarSucces(
            context: context,
            msg: "Itens da Produção baixados com sucesso !",
            title: "Baixa de Produção");
      },
    );
    // configura o  AlertDialog
    AlertDialog alerta = AlertDialog(
      title: Text("Baixa da Produção"),
      content: Text("Deseja realmente fazer a baixa da produção?"),
      actions: [cancelButton, confirmButton],
    );
    // exibe o dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }
}
