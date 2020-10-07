import 'package:bucks/src/classes/producao.dart';
import 'package:bucks/src/pages/producao/producao_list/producao_list_controller.dart';
import 'package:bucks/src/pages/producao/widgets/buttonsProducaoItem.dart';
import 'package:bucks/src/pages/producao/widgets/dropdown_find.dart';
import 'package:bucks/src/pages/producao/widgets/producaoItemDt.dart';
import 'package:bucks/src/shared/utils/colors.dart';
import 'package:bucks/src/shared/widgets/card_custom.dart';
import 'package:bucks/src/shared/widgets/flat_button_app.dart';
import 'package:bucks/src/shared/widgets/text_field_app.dart';
import 'package:bucks/src/shared/widgets/text_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../producao_controller.dart';

class CardProducaoItem extends StatefulWidget {
  final ProducaoController store;
  final ProducaoListController storeProducaoList;

  const CardProducaoItem(
      {Key key, @required this.store, @required this.storeProducaoList})
      : super(key: key);

  @override
  _CardProducaoItemState createState() => _CardProducaoItemState();
}

class _CardProducaoItemState extends State<CardProducaoItem> {
  ProducaoController get store => widget.store;
  ProducaoListController get storeProducaoList => widget.storeProducaoList;

  CardCustom cadastroProducao() {
    List<Widget> list = List();
    List<Widget> list2 = List();

    list.add(CorDeFundo.ContainerDecorationPadrao(
        text: 'Item Produção', fontSize: 24, fontWeight: FontWeight.bold));
    list.add(SizedBox(height: 10));
    list.add(DropdownFindItemEstoqueEntrada(
      store: storeProducaoList,
      store2: store,
    ));

    //list.add(SizedBox(height: 25));

    /*list.add(
      Container(
        width: 250,
        child: FlatButtonApp(
          label: "Salvar Produção Item",
          onPressed: () =>
              store.salvar(store: store, storeProducaoList: storeProducaoList),
        ),
      ),
    );*/

    list.add(SizedBox(height: 25));

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
    return cadastroProducao();
  }
}

class CardProducaoList extends StatefulWidget {
  final ProducaoListController store;

  const CardProducaoList({Key key, @required this.store}) : super(key: key);

  @override
  _CardProducaoListState createState() => _CardProducaoListState();
}

class _CardProducaoListState extends State<CardProducaoList> {
  ProducaoListController get store => widget.store;

  CardCustom listaProducao() {
    List<Widget> list = List();
    list.add(
      Observer(builder: (context) {
        if (!store.hasResultsProducao) {
          return Container();
        }
        if (store.producoes.isEmpty) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextMessage(
                'Nenhum item encontrado. \nClique aqui para tentar novamente.',
                fontSize: 18,
                // onRefresh: store.fetchItems,
              ),
            ],
          );
        }
        return DataTable(
          columns: [
            DataColumn(
              label: Text("ID"),
              numeric: false,
            ),
            DataColumn(
              label: Text("TIPO"),
              numeric: false,
            ),
            DataColumn(
              label: Text("DESCRIÇÃO"),
              numeric: false,
            ),
            DataColumn(
              label: Text("DATA INI"),
              numeric: false,
            ),
            DataColumn(
              label: Text("DATA FIM"),
              numeric: false,
            ),
            DataColumn(
              label: Text("STATUS"),
              numeric: false,
            ),
          ],
          rows: store.producoes
              .map(
                (producao) => DataRow(
                  cells: [
                    DataCell(
                      Text(producao.id.toString()),
                    ),
                    DataCell(
                      Text(producao.fkProducaoTipoId.toString()),
                    ),
                    DataCell(
                      Text(producao.descr),
                    ),
                    DataCell(
                      Text(producao.dtProducaoIni),
                    ),
                    DataCell(
                      Text(producao.dtProducaoFim),
                    ),
                    DataCell(
                      Text(producao.cdStatus.toString()),
                    ),
                  ],
                ),
              )
              .toList(),
        );
      }),
    );
    // list.add(SizedBox(height: 10));
    // list.add(
    //   Container(
    //     width: 250,
    //     child: FlatButtonApp(
    //       label: "Salvar",
    //       onPressed: () => store.salvarFarmacia(store: store),
    //     ),
    //   ),
    // );

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
    return listaProducao();
  }
}

class CardButton extends StatefulWidget {
  final ProducaoController store;
  final ProducaoListController storeProducaoList;
  final Producao producao;

  const CardButton(
      {Key key,
      @required this.store,
      @required this.storeProducaoList,
      @required this.producao})
      : super(key: key);

  @override
  _CardButton createState() => _CardButton();
}

class _CardButton extends State<CardButton> {
  ProducaoController get store => widget.store;
  ProducaoListController get storeProducaoList => widget.storeProducaoList;
  Producao get producao => widget.producao;

  CardCustom buttons() {
    List<Widget> list = List();

    list.add(ButtonsProducaoItem(
      store: widget.store,
      storeProducaoList: storeProducaoList,
      producao: producao,
    ));

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
