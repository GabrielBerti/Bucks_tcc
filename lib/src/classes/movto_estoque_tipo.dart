import 'entity_base.dart';

class MovtoEstoqueTipo extends EntityBase {
  int id;
  String descr;
  String cdTipoMovto;

  MovtoEstoqueTipo({this.id, this.descr, this.cdTipoMovto});

  MovtoEstoqueTipo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    descr = json['descr'];
    cdTipoMovto = json['cd_tipo_movto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['descr'] = this.descr;
    data['cd_tipo_movto'] = this.cdTipoMovto;
    return data;
  }
}
