// import 'package:bucks/src/classes/producaoTipo.dart';

import 'entity_base.dart';

class Producao extends EntityBase {
  int id;
  int fkProducaoTipoId;
  String fkProducaoTipoDescr;
  String descr;
  double vlMo;
  double vlCustosInd;
  String dtProducaoIni; // 2016-01-01 10:20:05.123 // YYYY-MM-DD HH:MM:SS.SSS
  String dtProducaoFim;
  String cdStatus;

  Producao(
      {this.id,
      this.fkProducaoTipoId,
      this.fkProducaoTipoDescr,
      this.descr,
      this.vlMo,
      this.vlCustosInd,
      this.dtProducaoIni,
      this.dtProducaoFim,
      this.cdStatus});

  Producao.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fkProducaoTipoId = json['fk_producao_tipo_id'];
    fkProducaoTipoDescr = json['fk_producao_tipo_descr'];
    descr = json['descr'];
    vlMo = json['vl_mo'];
    vlCustosInd = json['vl_custos_ind'];
    dtProducaoIni = json['dt_producao_ini'];
    dtProducaoFim = json['dt_producao_fim'];
    cdStatus = json['cd_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fk_producao_tipo_id'] = this.fkProducaoTipoId;
    //data['fk_producao_tipo_descr'] = this.fkProducaoTipoDescr;
    data['descr'] = this.descr;
    data['vl_mo'] = this.vlMo;
    data['vl_custos_ind'] = this.vlCustosInd;
    data['dt_producao_ini'] = this.dtProducaoIni;
    data['dt_producao_fim'] = this.dtProducaoFim;
    data['cd_status'] = this.cdStatus;
    return data;
  }
}
