import 'entity_base.dart';

class ProducaoItem extends EntityBase {
  int seq; //PK
  int fkProducaoId; //PK
  int fkItemId;
  double qt;
  double vlUnit;
  String cdTipo; // E=Entrada S=Saida
  String cdStatus;

  String descrItem;
  String descrProducao;

  ProducaoItem(
      {this.seq,
      this.fkProducaoId,
      this.fkItemId,
      this.qt,
      this.vlUnit,
      this.cdTipo,
      this.cdStatus,
      this.descrItem,
      this.descrProducao});

  ProducaoItem.fromJson(Map<String, dynamic> json) {
    fkProducaoId = json['fk_producao_id'];
    seq = json['seq'];
    fkItemId = json['fk_item_id'];
    descrItem = json['descrItem'];
    descrProducao = json['descrProducao'];
    qt = json['qt'];
    vlUnit = json['vl_unit'];
    cdTipo = json['cd_tipo'];
    cdStatus = json['cd_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fk_producao_id'] = this.fkProducaoId;
    data['seq'] = this.seq;
    data['fk_item_id'] = this.fkItemId;
    //data['descrProducao'] = this.descrProducao;
    //data['descrItem'] = this.descrItem;
    data['qt'] = this.qt;
    data['vl_unit'] = this.vlUnit;
    data['cd_tipo'] = this.cdTipo;
    data['cd_status'] = this.cdStatus;
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
