import 'package:bucks/src/classes/entity_base.dart';

class CgRefCodes extends EntityBase
{
  int id;
  String rvDommain;
  String rvLowValue;
  String rvHighValue;
  String rvDescr;
  String rvAbrev;

  CgRefCodes({this.id, this.rvDommain, this.rvHighValue, this.rvDescr, this.rvAbrev});

  CgRefCodes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rvDommain = json['rv_dommain'];
    rvLowValue = json['rv_low_value'];
    rvHighValue = json['rv_high_value'];
    rvDescr = json['rv_descr'];
    rvAbrev = json['rv_abrev'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['rv_dommain'] = this.rvDommain;
    data['rv_low_value'] = this.rvLowValue;
    data['rv_high_value'] = this.rvHighValue;
    data['rv_descr'] = this.rvDescr;
    data['rv_abrev'] = this.rvAbrev;
    return data;
  }

}