import 'package:bucks/src/pages/movto_estoque/movto_estoque_controller.dart';
import 'package:bucks/src/shared/utils/date.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

// import 'package:bucks/src/shared/utils/datatime.dart';
import 'package:flutter/material.dart';

import 'movto_estoque_list_controller.dart';
import 'widgets/card_movto_estoque.dart';

class MovtoEstoquePage extends StatefulWidget {
  final String title;
  final MovtoEstoqueListController storeMovtoEstoqueList;
  const MovtoEstoquePage(
      {Key key,
      this.title = "Cadastro Movto Estoque",
      @required this.storeMovtoEstoqueList})
      : super(key: key);

  @override
  _MovtoEstoquePageState createState() => _MovtoEstoquePageState();
}

class _MovtoEstoquePageState extends State<MovtoEstoquePage> {
  DateTime data;
  var _textDate = TextEditingController();
  MovtoEstoqueController store;
  MovtoEstoqueListController get storeMovtoEstoqueList =>
      widget.storeMovtoEstoqueList;

  @override
  void initState() {
    super.initState();
    store = MovtoEstoqueController();

    _textDate.text = dateFormat("dd/MM/yyyy", DateTime.now());
    data = DateTime.now();
    //final format = DateFormat("dd/MM/yyyy");
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
              CardMovtoEstoque(
                store: store,
                storeMovtoEstoqueList: storeMovtoEstoqueList,
              ),
              /*Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 200),
                      child: DateTimeField(
                        onChanged: (value) {
                          data = value;
                          //print(value);
                        },
                        controller: _textDate,
                        readOnly: true,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.normal),
                        //format: format,
                        onShowPicker: (context, currentValue) {
                          return showDatePicker(
                              context: context,
                              firstDate: DateTime(1900),
                              initialDate: currentValue ?? DateTime.now(),
                              lastDate: DateTime(2100));
                        },
                        format: null,
                      ),
                    ),
                  ),
                ],
              ),*/
              //Buttons(store: store, storeItemList: storeItemList,),
            ],
          ),
        ));
  }
}
