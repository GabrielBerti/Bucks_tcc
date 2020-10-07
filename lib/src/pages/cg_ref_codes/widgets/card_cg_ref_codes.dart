import 'package:bucks/src/pages/cg_ref_codes/cg_ref_codes_list/cg_ref_codes_list_controller.dart';
import 'package:bucks/src/shared/widgets/card_custom.dart';
import 'package:bucks/src/shared/widgets/flat_button_app.dart';
import 'package:bucks/src/shared/widgets/text_field_app.dart';
import 'package:bucks/src/shared/widgets/text_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../cg_ref_codes_controller.dart';

class CardCgRefCodes extends StatefulWidget {
  final CgRefCodesController store;
  final CgRefCodesListController storeCgRefCodesList;

  const CardCgRefCodes(
      {Key key, @required this.store, @required this.storeCgRefCodesList})
      : super(key: key);

  @override
  _CardCgRefCodesState createState() => _CardCgRefCodesState();
}

class _CardCgRefCodesState extends State<CardCgRefCodes> {
  CgRefCodesController get store => widget.store;
  CgRefCodesListController get storeCgRefCodesList => widget.storeCgRefCodesList;

  CardCustom cadastroCgRefCodes() {
    List<Widget> list = List();
    list.add(TextFieldApp(
      controller: store.rvDomain,
      text: "Digite o domínio",      
    ));
    list.add(SizedBox(height: 10));
    
    list.add(TextFieldApp(
      controller: store.rvLowValue,
      text: "Digite o valor (ou minimo/inicial)",
    ));
    list.add(SizedBox(height: 10));

    list.add(TextFieldApp(
      controller: store.rvHighValue,
      text: "Digite o valor máximo ou final (quando necessário)",
    ));
    list.add(SizedBox(height: 10));

    list.add(TextFieldApp(
      controller: store.rvDescr,
      text: "Digite a descrição",
    ));
    list.add(SizedBox(height: 10));

    list.add(TextFieldApp(
      controller: store.rvAbrev,
      text: "Digite a abreviação",
    ));
    list.add(SizedBox(height: 10));

    list.add(
      Container(
        width: 250,
        child: FlatButtonApp(
          label: "Salvar",
          onPressed: () => store.salvar(store: store, 
                                        storeCgRefCodesList: storeCgRefCodesList),
        ),
      ),
    );

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
    return cadastroCgRefCodes();
  }
}

class CardCgRefCodesList extends StatefulWidget {
  final CgRefCodesListController store;

  const CardCgRefCodesList({Key key, @required this.store}) : super(key: key);

  @override
  _CardCgRefCodesListState createState() => _CardCgRefCodesListState();
}

class _CardCgRefCodesListState extends State<CardCgRefCodesList> {
  CgRefCodesListController get store => widget.store;

  CardCustom listaCgRefCodes() {
    List<Widget> list = List();
    list.add(
      Observer(builder: (context) {
        if (!store.hasResultsCgRefCodes) {
          return Container();
        }
        if (store.regList.isEmpty) {
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
              label: Text("Domínio"),
              numeric: false,
            ),
            DataColumn(
              label: Text("Valor (min)*"),
              numeric: false,
            ),
            DataColumn(
              label: Text("Valor (max)"),
              numeric: false,
            ),
            DataColumn(
              label: Text("Descrição"),
              numeric: false,
            ),
            DataColumn(
              label: Text("Abreviação"),
              numeric: false,
            ),
          ],
          rows: store.regList
              .map(
                (reg) => DataRow(
                  cells: [
                    DataCell(
                      Text(reg.rvDommain),
                    ),
                    DataCell(
                      Text(reg.rvLowValue),
                    ),
                    DataCell(
                      Text(reg.rvHighValue),
                    ),
                    DataCell(
                      Text(reg.rvDescr),
                    ),
                    DataCell(
                      Text(reg.rvAbrev),
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
    return listaCgRefCodes();
  }
}
