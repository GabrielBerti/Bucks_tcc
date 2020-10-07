import 'package:bucks/src/classes/entity_base.dart';

class ItemUnmed extends EntityBase {
  String id;
  String descr;

  ItemUnmed({this.id, this.descr});

  ItemUnmed.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    descr = json['descr'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['descr'] = this.descr;
    return data;
  }
}
