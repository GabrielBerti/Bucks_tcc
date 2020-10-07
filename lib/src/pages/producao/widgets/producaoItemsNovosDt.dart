import 'package:bucks/src/pages/producao/producao_controller.dart';
import 'package:bucks/src/pages/producao/producao_list/producao_list_controller.dart';
import 'package:bucks/src/pages/producao/widgets/datatableProducaoItemNovos.dart';
import 'package:bucks/src/shared/widgets/card_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ProducaoItensDtNovoEntrada extends StatefulWidget {
  final ProducaoController store;
  final ProducaoListController storeProducaoListController;

  const ProducaoItensDtNovoEntrada(
      {Key key, this.store, this.storeProducaoListController})
      : super(key: key);
  @override
  _ProducaoItensDtNovoEntradaState createState() =>
      _ProducaoItensDtNovoEntradaState();
}

class _ProducaoItensDtNovoEntradaState
    extends State<ProducaoItensDtNovoEntrada> {
  ProducaoController get store => widget.store;
  ProducaoListController get storeProducaoListController =>
      widget.storeProducaoListController;
  bool screen;
  Orientation orientation;
  // List<Item> itemsList;

  // newList() => store.itemsList = Item.toJsonList(store.itemsDataTable);

  items() {
    return Observer(
      builder: (BuildContext context) {
        // newList();

        if (storeProducaoListController.hasResultsProducaoItemDtNovoEntrada) {
          return Container();
        }

        if (storeProducaoListController.producaoItensDtNovoEntrada.isEmpty) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text('Nenhum item inserido'),
              ),
            ],
          );
        }

        return DatatableProducaoItemEstoqueEntrada(
          itensProducao: storeProducaoListController.producaoItensDtNovoEntrada,
          store: storeProducaoListController,
        );
      },
    );
  }

  CardCustom listaItems() {
    List<Widget> list = List();
    list.add(items());
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
    final double shortsSide = MediaQuery.of(context).size.shortestSide;
    screen = shortsSide < 600;
    orientation = MediaQuery.of(context).orientation;
    return listaItems();
  }
}

//----------------------------------------------------------------------------------------------------------
class ProducaoItensSaida extends StatefulWidget {
  final ProducaoController store;
  final ProducaoListController storeProducaoListController;

  const ProducaoItensSaida(
      {Key key, this.store, this.storeProducaoListController})
      : super(key: key);
  @override
  _ProducaoItensSaidaState createState() => _ProducaoItensSaidaState();
}

class _ProducaoItensSaidaState extends State<ProducaoItensSaida> {
  ProducaoController get store => widget.store;
  ProducaoListController get storeProducaoListController =>
      widget.storeProducaoListController;
  bool screen;
  Orientation orientation;
  // List<Item> itemsList;

  // newList() => store.itemsList = Item.toJsonList(store.itemsDataTable);

  items() {
    return Observer(
      builder: (BuildContext context) {
        // newList();

        if (storeProducaoListController.producaoItensDtSaida.isEmpty) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text('Nenhum item inserido'),
              ),
            ],
          );
        }

        return DatatableProducaoItemSaida(
          itensProducao: storeProducaoListController.producaoItensDtSaida,
          store: storeProducaoListController,
        );
      },
    );
  }

  CardCustom listaItems() {
    List<Widget> list = List();
    list.add(items());
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
    final double shortsSide = MediaQuery.of(context).size.shortestSide;
    screen = shortsSide < 600;
    orientation = MediaQuery.of(context).orientation;
    return listaItems();
  }
}

//----------------------------------------------------------------------------------------------------------
class ProducaoItensIndiretos extends StatefulWidget {
  final ProducaoController store;
  final ProducaoListController storeProducaoListController;

  const ProducaoItensIndiretos(
      {Key key, this.store, this.storeProducaoListController})
      : super(key: key);
  @override
  _ProducaoItensIndiretosState createState() => _ProducaoItensIndiretosState();
}

class _ProducaoItensIndiretosState extends State<ProducaoItensIndiretos> {
  ProducaoController get store => widget.store;
  ProducaoListController get storeProducaoListController =>
      widget.storeProducaoListController;
  bool screen;
  Orientation orientation;
  // List<Item> itemsList;

  // newList() => store.itemsList = Item.toJsonList(store.itemsDataTable);

  items() {
    return Observer(
      builder: (BuildContext context) {
        // newList();

        if (!storeProducaoListController.hasResultsItemIndireto) {
          return Container();
        }

        if (storeProducaoListController.producaoItensIndiretosDt.isEmpty) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text('Nenhum item inserido'),
              ),
            ],
          );
        }

        return DatatableItensIndiretos(
          itensProducao: storeProducaoListController.producaoItensIndiretosDt,
          store: storeProducaoListController,
        );
      },
    );
  }

  CardCustom listaItems() {
    List<Widget> list = List();
    list.add(items());
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
    final double shortsSide = MediaQuery.of(context).size.shortestSide;
    screen = shortsSide < 600;
    orientation = MediaQuery.of(context).orientation;
    return listaItems();
  }
}
