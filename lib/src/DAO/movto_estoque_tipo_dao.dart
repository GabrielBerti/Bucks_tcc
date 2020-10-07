import 'package:bucks/src/classes/movto_estoque_tipo.dart';
import 'package:bucks/src/shared/utils/constants.dart';

import 'base_dao.dart';

class MovtoEstoqueTipoDAO extends BaseDAO<MovtoEstoqueTipo> {
  @override
  MovtoEstoqueTipo fromJson(Map<String, dynamic> map) {
    return MovtoEstoqueTipo.fromJson(map);
  }

  @override
  String get sqlComJoin => null;

  @override
  String get tableName => table_name_movto_estoque_tipo;

  @override
  String get orderByCols => null;
}
