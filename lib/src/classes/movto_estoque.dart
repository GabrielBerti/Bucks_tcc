import 'entity_base.dart';

class MovtoEstoque extends EntityBase {
  int id;
  String dt;
  double qtd;
  double vlUnit;
  double qtSaldoAnt;
  double qtSaldoPos;
  double vlUnitAnt;
  double vlUnitPos;

  // colunas de outras tabelas
  int fkItemEstoqueItemId; //
  int fkMovtoEstoqueTipoId; //
  int fkProditemProducaoId;
  int fkProditemSeq;

  String fkMovtoEstoqueTipoDescr;
  String fkMovtoEstoqueTipoCd;
  String fkItemDescr;
  String fkProducaoDescr;

  MovtoEstoque({
    this.id,
    this.fkItemEstoqueItemId,
    this.fkMovtoEstoqueTipoId,
    this.fkProditemProducaoId,
    this.fkProditemSeq,
    this.fkMovtoEstoqueTipoDescr,
    this.fkMovtoEstoqueTipoCd,
    this.fkItemDescr,
    this.fkProducaoDescr,
    this.dt,
    this.qtd,
    this.vlUnit,
    this.qtSaldoAnt,
    this.qtSaldoPos,
    this.vlUnitAnt,
    this.vlUnitPos,
  });

  MovtoEstoque.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    fkItemEstoqueItemId = json['fk_item_estoque_item_id'];
    fkMovtoEstoqueTipoId = json['fk_movto_estoque_tipo_id'];
    fkProditemProducaoId = json['fk_proditem_producao_id'];
    fkProditemSeq = json['fk_proditem_seq'];

    fkMovtoEstoqueTipoDescr = json['fk_movto_estoque_tipo_descr'];
    fkMovtoEstoqueTipoCd = json['fk_movto_estoque_tipo_cd'];
    fkItemDescr = json['fk_item_descr'];
    fkProducaoDescr = json['fk_prod_descr'];
    if (fkProducaoDescr == fkItemDescr) {
      fkProducaoDescr = null;
    }

    dt = json['dt'];
    qtd = json['qtd'];
    vlUnit = json[('vl_unit').toLowerCase()];
    qtSaldoAnt = json['qt_saldo_ant'];
    qtSaldoPos = json['qt_saldo_pos'];
    vlUnitAnt = json['vl_unit_ant'];
    vlUnitPos = json['vl_unit_pos'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;

    data['fk_item_estoque_item_id'] = this.fkItemEstoqueItemId;
    data['fk_movto_estoque_tipo_id'] = this.fkMovtoEstoqueTipoId;
    data['fk_proditem_producao_id'] = this.fkProditemProducaoId;
    data['fk_proditem_seq'] = this.fkProditemSeq;

    //data['fk_movto_estoque_tipo_descr'] = this.fkMovtoEstoqueTipoDescr;
    //data['fk_item_descr'] = this.fkItemDescr;
    //data['fk_prod_descr'] = this.fkProducaoDescr;

    data['dt'] = this.dt;
    data['qtd'] = this.qtd;
    data['vl_unit'] = this.vlUnit;
    data['qt_saldo_ant'] = this.qtSaldoAnt;
    data['qt_saldo_pos'] = this.qtSaldoPos;
    data['vl_unit_ant'] = this.vlUnitAnt;
    data['vl_unit_pos'] = this.vlUnitPos;

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
