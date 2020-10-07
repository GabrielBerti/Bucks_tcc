import 'package:flutter/material.dart';
import 'cg_ref_codes_controller.dart';
import 'cg_ref_codes_list/cg_ref_codes_list_controller.dart';
import 'widgets/card_cg_ref_codes.dart';

class CgRefCodesPage extends StatefulWidget {
  final String title;
  final CgRefCodesListController storeCgRefCodesList;
  const CgRefCodesPage(
      {Key key,
      this.title = "Cadastro de Codigos Internos",
      @required this.storeCgRefCodesList})
      : super(key: key);

  @override
  _CgRefCodesPageState createState() => _CgRefCodesPageState();
}

class _CgRefCodesPageState extends State<CgRefCodesPage> {
  CgRefCodesController store;
  CgRefCodesListController get storeCgRefCodesList => widget.storeCgRefCodesList;

  @override
  void initState() {
    super.initState();
    store = CgRefCodesController();
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
              CardCgRefCodes(
                store: store,
                storeCgRefCodesList: storeCgRefCodesList,
              ),
            ],
          ),
        ));
  }
}
