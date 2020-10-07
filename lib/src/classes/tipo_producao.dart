import 'entity_base.dart';

class TipoProducao extends EntityBase {
  int id;
  String descr;

  TipoProducao({this.id, this.descr});

  TipoProducao.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    descr = json['descr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['descr'] = this.descr;
    return data;
  }
}
