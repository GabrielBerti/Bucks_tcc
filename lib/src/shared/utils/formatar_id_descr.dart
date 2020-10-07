String formatarIdDescr(String pId, String pDescr) {
  String _retorno = '-1';

  try {
    if (pId == "null" && pDescr != null) {
      _retorno = pDescr;
    } else if (pId != null && pDescr != null) {
      _retorno = pId + ')' + pDescr;
    }
  } catch (e) {
    _retorno = 'error ' + e.toString();
  }

  return _retorno;
}
