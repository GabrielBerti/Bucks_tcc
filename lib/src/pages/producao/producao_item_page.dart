import 'package:bucks/src/classes/producao.dart';
import 'package:bucks/src/pages/producao/producao_controller.dart';
import 'package:bucks/src/pages/producao/producao_list/producao_list_controller.dart';
import 'package:bucks/src/pages/producao/widgets/card_producao_item.dart';
import 'package:bucks/src/pages/producao/widgets/dropdown_find.dart';
import 'package:bucks/src/pages/producao/widgets/producaoItemsNovosDt.dart';
import 'package:bucks/src/pages/producao/widgets/radioButtons.dart';
import 'package:bucks/src/shared/utils/colors.dart';
import 'package:flutter/material.dart';

class ProducaoItemPage extends StatefulWidget {
  final String title;
  final ProducaoListController storeProducaoList;
  final Producao producao;
  const ProducaoItemPage(
      {Key key,
      this.title = "Cadastro de Producao Item",
      @required this.storeProducaoList,
      @required this.producao})
      : super(key: key);

  @override
  _ProducaoItemPageState createState() => _ProducaoItemPageState();
}

class _ProducaoItemPageState extends State<ProducaoItemPage> {
  ProducaoController store;
  ProducaoListController get storeProducaoList => widget.storeProducaoList;
  Producao get producao => widget.producao;

  @override
  void initState() {
    super.initState();
    store = ProducaoController();
    //storeProducaoList.producaoItensDt.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              RadioButtonEntrSaida(
                store: widget.storeProducaoList,
              ),
              // itens de estoque para entrada
              SizedBox(height: 10),
              CorDeFundo.ContainerDecorationPadrao(
                  text: 'Itens de Entrada(E)',
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
              SizedBox(height: 10),
              DropdownFindItemEstoqueEntrada(
                store: storeProducaoList,
                store2: store,
                producao: producao,
              ),

              ProducaoItensDtNovoEntrada(
                  store: store, storeProducaoListController: storeProducaoList),
              SizedBox(height: 10),
              // itens indiretos
              CorDeFundo.ContainerDecorationPadrao(
                  text: 'Itens Indiretos (E)',
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
              SizedBox(height: 10),
              DropdownFindItemIndireto(
                store: storeProducaoList,
                store2: store,
                producao: producao,
              ),
              ProducaoItensIndiretos(
                  store: store, storeProducaoListController: storeProducaoList),
              // itens de estoque para saida
              CorDeFundo.ContainerDecorationPadrao(
                  text: 'Itens de Saída (S)',
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
              SizedBox(height: 10),
              DropdownFindItemSaida(
                store: storeProducaoList,
                store2: store,
                producao: producao,
              ),
              ProducaoItensSaida(
                  store: store, storeProducaoListController: storeProducaoList),
              CardButton(
                store: store,
                storeProducaoList: storeProducaoList,
                producao: producao,
              ),
            ],
          ),
        ));
  }
}
