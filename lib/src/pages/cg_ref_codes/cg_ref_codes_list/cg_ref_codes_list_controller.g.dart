// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cg_ref_codes_list_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CgRefCodesListController on _CgRefCodesListControllerBase, Store {
  Computed<bool> _$hasResultsCgRefCodesComputed;

  @override
  bool get hasResultsCgRefCodes => (_$hasResultsCgRefCodesComputed ??=
          Computed<bool>(() => super.hasResultsCgRefCodes))
      .value;

  final _$regListAtom = Atom(name: '_CgRefCodesListControllerBase.regList');

  @override
  List<CgRefCodes> get regList {
    _$regListAtom.context.enforceReadPolicy(_$regListAtom);
    _$regListAtom.reportObserved();
    return super.regList;
  }

  @override
  set regList(List<CgRefCodes> value) {
    _$regListAtom.context.conditionallyRunInAction(() {
      super.regList = value;
      _$regListAtom.reportChanged();
    }, _$regListAtom, name: '${_$regListAtom.name}_set');
  }

  final _$regListObsAtom =
      Atom(name: '_CgRefCodesListControllerBase.regListObs');

  @override
  ObservableFuture<List<CgRefCodes>> get regListObs {
    _$regListObsAtom.context.enforceReadPolicy(_$regListObsAtom);
    _$regListObsAtom.reportObserved();
    return super.regListObs;
  }

  @override
  set regListObs(ObservableFuture<List<CgRefCodes>> value) {
    _$regListObsAtom.context.conditionallyRunInAction(() {
      super.regListObs = value;
      _$regListObsAtom.reportChanged();
    }, _$regListObsAtom, name: '${_$regListObsAtom.name}_set');
  }

  final _$listarAsyncAction = AsyncAction('listar');

  @override
  Future<List<CgRefCodes>> listar() {
    return _$listarAsyncAction.run(() => super.listar());
  }
}
