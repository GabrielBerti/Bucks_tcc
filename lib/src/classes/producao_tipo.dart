import 'entity_base.dart';

class ProducaoTipo extends EntityBase
{
  int id;
  String descr;

  ProducaoTipo(this.id
         , this.descr);

  ProducaoTipo.fromJson(Map<String, dynamic> json) {
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