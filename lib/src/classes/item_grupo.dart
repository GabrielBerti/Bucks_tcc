import 'entity_base.dart';

class ItemGrupo extends EntityBase {
  int id;
  String descr;

  ItemGrupo({this.id, this.descr});

  ItemGrupo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    descr = json['descr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['descr'] = this.descr;
    return data;
  }
}
