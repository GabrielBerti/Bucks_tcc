import 'package:bucks/src/DAO/cg_ref_codes_dao.dart';
import 'package:bucks/src/classes/cg_ref_codes.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'cg_ref_codes_list/cg_ref_codes_list_controller.dart';

part 'cg_ref_codes_controller.g.dart';

class CgRefCodesController = _CgRefCodesControllerBase with _$CgRefCodesController;

abstract class _CgRefCodesControllerBase with Store {
  CgRefCodesDAO cgRefCodesDAO;

  @observable
  TextEditingController id = TextEditingController();

  @observable
  TextEditingController rvDomain = TextEditingController();

  @observable
  TextEditingController rvLowValue = TextEditingController();

  @observable
  TextEditingController rvHighValue = TextEditingController();

  @observable
  TextEditingController rvDescr = TextEditingController();

  @observable
  TextEditingController rvAbrev = TextEditingController();

  _CgRefCodesControllerBase() {
    cgRefCodesDAO = cgRefCodesDAO ?? CgRefCodesDAO();
  }

  @action
  salvar(
      {@required CgRefCodesController store,
       @required CgRefCodesListController storeCgRefCodesList}) async {

    CgRefCodes cgRefCodes = CgRefCodes();
    cgRefCodes.rvDommain = store.rvDomain.text;
    cgRefCodes.rvLowValue = store.rvLowValue.text;
    cgRefCodes.rvHighValue = store.rvHighValue.text;
    cgRefCodes.rvDescr = store.rvDescr.text;
    cgRefCodes.rvAbrev = store.rvAbrev.text;

    await cgRefCodesDAO.salvar(cgRefCodes);

    await storeCgRefCodesList.listar();
  }

  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
