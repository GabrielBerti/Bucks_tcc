import 'package:bucks/src/DAO/producao_item_dao.dart';
import 'package:bucks/src/classes/item.dart';
import 'package:bucks/src/classes/producao.dart';
import 'package:bucks/src/classes/producao_item.dart';
import 'package:bucks/src/pages/item/item_controller.dart';
import 'package:bucks/src/pages/item/item_list/item_list_controller.dart';
import 'package:bucks/src/pages/producao/producao_controller.dart';
import 'package:bucks/src/pages/producao/producao_list/producao_list_controller.dart';
import 'package:bucks/src/pages/producao/producao_list/producao_list_page.dart';
import 'package:bucks/src/shared/utils/nav.dart';
import 'package:bucks/src/shared/widgets/flat_button_app.dart';
import 'package:bucks/src/shared/widgets/snackbar_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../shared/widgets/button.dart';
import '../../dash_board.dart';
import '../producao_item_page.dart';
import '../producao_page.dart';

class ButtonsProducaoItem extends StatefulWidget {
  final ProducaoController store;
  final ProducaoListController storeProducaoList;
  final Producao producao;

  ButtonsProducaoItem(
      {Key key,
      @required this.store,
      @required this.storeProducaoList,
      @required this.producao})
      : super(key: key);

  @override
  _ButtonsProducaoItem createState() => _ButtonsProducaoItem();
}

class _ButtonsProducaoItem extends State<ButtonsProducaoItem> {
  ProducaoController get store => widget.store;
  ProducaoListController get storeProducaoList => widget.storeProducaoList;
  Producao get producao => widget.producao;

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
              width: 250,
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
    //print('${producao.id}');
    String msgErro;
    List<Item> itensQtdMinUltrapassada = [];

    for (var prodItem in storeProducaoList.producaoItensDtNovoEntrada) {
      if (prodItem.cdTipo == null ||
          prodItem.qt == null ||
          prodItem.vlUnit == null) {
        msgErro = "Existem campos que não estão preenchidos";
      }
    }

    for (var prodItem in storeProducaoList.producaoItensIndiretosDt) {
      if (prodItem.cdTipo == null ||
          prodItem.qt == null ||
          prodItem.vlUnit == null) {
        msgErro = "Existem campos que não estão preenchidos";
      }
    }

    for (var prodItem in storeProducaoList.producaoItensDtSaida) {
      if (prodItem.cdTipo == null ||
          prodItem.qt == null ||
          prodItem.vlUnit == null) {
        msgErro = "Existem campos que não estão preenchidos";
      }
    }

    if (msgErro == null) {
      int nextSeq = 0;

      for (var prodItem in storeProducaoList.producaoItensDtNovoEntrada) {
        if (nextSeq == 0) {
          if (storeProducaoList.producaoItensDt.length > 0) {
            for (var prod in storeProducaoList.producaoItensDt) {
              nextSeq = storeProducaoList.producaoItensDt.last.seq + 1;
            }
          } else {
            nextSeq = nextSeq + 1;
          }
        } else {
          nextSeq++;
        }

        prodItem.fkProducaoId = producao.id;
        prodItem.seq = nextSeq;

        //prodItem.cdStatus = "S"; somente para teste

        await storeProducaoList.verificaQtdEstoque(
            idItem: prodItem.fkItemId,
            qtdPedida: prodItem.qt,
            producaoListController: storeProducaoList);

        if (storeProducaoList.possuiQtdEstoque == true) {
          await storeProducaoList.verificaVlMinEstoque(
              idItem: prodItem.fkItemId,
              producaoItem: prodItem,
              producaoListController: storeProducaoList);

          if (storeProducaoList.qtdMinEstoqueUltrapassada == true) {
            Item item = Item();
            item.id = prodItem.fkItemId;
            item.descr = prodItem.descrItem;

            itensQtdMinUltrapassada.add(item);
          }

          storeProducaoList.salvarProducaoItem(
              producaoItem: prodItem, producao: producao);
        } else {
          msgErro =
              "Item: ${prodItem.descrItem}, não possui esta quantidade disponível no estoque !";
          snackbarError(context: context, msg: msgErro);
        }
      }

      if (msgErro == null) {
        for (var prodItem in storeProducaoList.producaoItensIndiretosDt) {
          if (nextSeq == 0) {
            if (storeProducaoList.producaoItensDt.length > 0) {
              for (var prod in storeProducaoList.producaoItensDt) {
                nextSeq = storeProducaoList.producaoItensDt.last.seq + 1;
              }
            } else {
              nextSeq = nextSeq + 1;
            }
          } else {
            nextSeq++;
          }

          prodItem.fkProducaoId = producao.id;
          prodItem.seq = nextSeq;

          storeProducaoList.salvarProducaoItem(
              producaoItem: prodItem, producao: producao);
        }
      }
      if (msgErro == null) {
        for (var prodItem in storeProducaoList.producaoItensDtSaida) {
          if (nextSeq == 0) {
            if (storeProducaoList.producaoItensDt.length > 0) {
              for (var prod in storeProducaoList.producaoItensDt) {
                nextSeq = storeProducaoList.producaoItensDt.last.seq + 1;
              }
            } else {
              nextSeq = nextSeq + 1;
            }
          } else {
            nextSeq++;
          }

          prodItem.fkProducaoId = producao.id;
          prodItem.seq = nextSeq;

          storeProducaoList.salvarProducaoItem(
              producaoItem: prodItem, producao: producao);
        }
      }
    } else {
      snackbarError(context: context, msg: msgErro);
    }

    if (msgErro == null) {
      if (itensQtdMinUltrapassada.length > 0) {
        String itens = "";
        for (var item in itensQtdMinUltrapassada) {
          itens = itens + item.id.toString();
          itens = itens + " - " + item.descr + " / ";
        }

        showAlertItemAbaixoQtdMinEstoque(context, itens);
      } else {
        Navigator.of(context).pop(false);

        /*pushReplacement(context, DashboardMateriaisModule());

        push(
            context,
            ProducaoListPage(
              producao: producao,
            ));

        push(
            context, 
            ProducaoPage( 
              producao: producao,
              storeProducaoList: storeProducaoList,
            ));*/

        snackbarSucces(
            context: context,
            msg: "Produção Item inserido com sucesso !",
            title: "Produção Item Inserido");
      }
    }
  }

  showAlertItemAbaixoQtdMinEstoque(BuildContext context, String descrMsg) {
    // configura o button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context, false);
        Navigator.of(context).pop(false);

        /*pushReplacement(context, DashboardMateriaisModule());

        push(
            context,
            ProducaoListPage(
              producao: producao,
            ));

        push(
            context,
            ProducaoPage(
              producao: producao,
              storeProducaoList: storeProducaoList,
            ));*/

        /*pushReplacement(context, DashboardMateriaisModule());
        push(
            context,
            ProducaoItemPage(
              producao: producao,
              storeProducaoList: storeProducaoList,
            )
            );*/
      },
    );

    // configura o  AlertDialog
    AlertDialog alerta = AlertDialog(
      title: Text(
          "Produção Item inserido com sucesso. Atenção! alguns itens estarão abaixo do valor mínimo de seu estoque quando essa produção for baixada:"),
      content: Text(descrMsg),
      actions: [okButton],
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
