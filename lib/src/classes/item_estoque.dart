import 'package:bucks/src/classes/entity_base.dart';

class ItemEstoque extends EntityBase {
  int fkItemId;
  double qtSaldo;
  double vlUnit;
  //double qtReservado;

  // campos de outras tabelas utilizados no json
  String fkItemDescr;
  int fkItemGrupoId;
  String fkItemGrupoDescr;
  String fkItemUnmedId;
  String fkItemUnmedDescr;
  int fkItemTipoId;
  String fkItemTipoDescr;

  ItemEstoque({this.fkItemId, this.qtSaldo, this.vlUnit});

  ItemEstoque.fromJson(Map<String, dynamic> json) {
    fkItemId = json['fk_item_id'];
    qtSaldo = json['qt_saldo'];
    vlUnit = json['vl_unit'];
    //qtReservado = json['qt_reservado'];

    // campos de outras tabelas utilizados no json
    fkItemDescr = json['fk_item_descr'];
    fkItemGrupoId = json['fk_item_grupo_id'];
    fkItemGrupoDescr = json['fk_item_grupo_descr'];
    fkItemUnmedId = json['fk_item_unmed_id'];
    fkItemUnmedDescr = json['fk_item_unmed_descr'];
    fkItemTipoId = json['fk_item_tipo_id'];
    fkItemTipoDescr = json['fk_item_tipo_descr'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fk_item_id'] = this.fkItemId;
    data['qt_saldo'] = this.qtSaldo;
    data['vl_unit'] = this.vlUnit;
    //data['qt_reservado'] = this.qtReservado;
    return data;
  }

  double calculaVlTotal(String qtd, String vlUnit) {
    double x, y;

    if (qtd == null || vlUnit == "null") {
      return 0;
    } else {
      x = double.parse(qtd);
      y = double.parse(vlUnit);

      return x * y;
    }
  }
}
