import 'package:bucks/src/pages/cg_ref_codes/widgets/card_cg_ref_codes.dart';
import 'package:bucks/src/shared/utils/nav.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../cg_ref_codes_page.dart';
import 'cg_ref_codes_list_controller.dart';

class CgRefCodesListPage extends StatefulWidget {
  final String title;
  const CgRefCodesListPage({Key key, this.title = "Consulta CG_REF_CODES"})
      : super(key: key);

  @override
  _CgRefCodesListPageState createState() => _CgRefCodesListPageState();
}

class _CgRefCodesListPageState extends State<CgRefCodesListPage> {
  CgRefCodesListController store;

  @override
  void initState() {
    super.initState();
    store = CgRefCodesListController();
    store.init();
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
            CardCgRefCodesList(store: store),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          push(
              context,
              CgRefCodesPage(
                storeCgRefCodesList: store,
              ));
        },
        child: Icon(FontAwesomeIcons.plus),
      ),
    );
  }
}
