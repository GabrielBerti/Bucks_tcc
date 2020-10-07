import 'package:bucks/src/classes/cg_ref_codes.dart';
import 'package:bucks/src/shared/utils/constants.dart';
import 'base_dao.dart';

class CgRefCodesDAO extends BaseDAO<CgRefCodes> {
  @override
  CgRefCodes fromJson(Map<String, dynamic> map) {
    return CgRefCodes.fromJson(map);
  }

  @override
  String get sqlComJoin => null;

  @override
  String get tableName => table_name_cg_ref_codes;

  @override
  String get orderByCols => null;
}
