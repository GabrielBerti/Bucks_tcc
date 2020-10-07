// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cg_ref_codes_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CgRefCodesController on _CgRefCodesControllerBase, Store {
  final _$idAtom = Atom(name: '_CgRefCodesControllerBase.id');

  @override
  TextEditingController get id {
    _$idAtom.context.enforceReadPolicy(_$idAtom);
    _$idAtom.reportObserved();
    return super.id;
  }

  @override
  set id(TextEditingController value) {
    _$idAtom.context.conditionallyRunInAction(() {
      super.id = value;
      _$idAtom.reportChanged();
    }, _$idAtom, name: '${_$idAtom.name}_set');
  }

  final _$rvDomainAtom = Atom(name: '_CgRefCodesControllerBase.rvDomain');

  @override
  TextEditingController get rvDomain {
    _$rvDomainAtom.context.enforceReadPolicy(_$rvDomainAtom);
    _$rvDomainAtom.reportObserved();
    return super.rvDomain;
  }

  @override
  set rvDomain(TextEditingController value) {
    _$rvDomainAtom.context.conditionallyRunInAction(() {
      super.rvDomain = value;
      _$rvDomainAtom.reportChanged();
    }, _$rvDomainAtom, name: '${_$rvDomainAtom.name}_set');
  }

  final _$rvLowValueAtom = Atom(name: '_CgRefCodesControllerBase.rvLowValue');

  @override
  TextEditingController get rvLowValue {
    _$rvLowValueAtom.context.enforceReadPolicy(_$rvLowValueAtom);
    _$rvLowValueAtom.reportObserved();
    return super.rvLowValue;
  }

  @override
  set rvLowValue(TextEditingController value) {
    _$rvLowValueAtom.context.conditionallyRunInAction(() {
      super.rvLowValue = value;
      _$rvLowValueAtom.reportChanged();
    }, _$rvLowValueAtom, name: '${_$rvLowValueAtom.name}_set');
  }

  final _$rvHighValueAtom = Atom(name: '_CgRefCodesControllerBase.rvHighValue');

  @override
  TextEditingController get rvHighValue {
    _$rvHighValueAtom.context.enforceReadPolicy(_$rvHighValueAtom);
    _$rvHighValueAtom.reportObserved();
    return super.rvHighValue;
  }

  @override
  set rvHighValue(TextEditingController value) {
    _$rvHighValueAtom.context.conditionallyRunInAction(() {
      super.rvHighValue = value;
      _$rvHighValueAtom.reportChanged();
    }, _$rvHighValueAtom, name: '${_$rvHighValueAtom.name}_set');
  }

  final _$rvDescrAtom = Atom(name: '_CgRefCodesControllerBase.rvDescr');

  @override
  TextEditingController get rvDescr {
    _$rvDescrAtom.context.enforceReadPolicy(_$rvDescrAtom);
    _$rvDescrAtom.reportObserved();
    return super.rvDescr;
  }

  @override
  set rvDescr(TextEditingController value) {
    _$rvDescrAtom.context.conditionallyRunInAction(() {
      super.rvDescr = value;
      _$rvDescrAtom.reportChanged();
    }, _$rvDescrAtom, name: '${_$rvDescrAtom.name}_set');
  }

  final _$rvAbrevAtom = Atom(name: '_CgRefCodesControllerBase.rvAbrev');

  @override
  TextEditingController get rvAbrev {
    _$rvAbrevAtom.context.enforceReadPolicy(_$rvAbrevAtom);
    _$rvAbrevAtom.reportObserved();
    return super.rvAbrev;
  }

  @override
  set rvAbrev(TextEditingController value) {
    _$rvAbrevAtom.context.conditionallyRunInAction(() {
      super.rvAbrev = value;
      _$rvAbrevAtom.reportChanged();
    }, _$rvAbrevAtom, name: '${_$rvAbrevAtom.name}_set');
  }

  final _$valueAtom = Atom(name: '_CgRefCodesControllerBase.value');

  @override
  int get value {
    _$valueAtom.context.enforceReadPolicy(_$valueAtom);
    _$valueAtom.reportObserved();
    return super.value;
  }

  @override
  set value(int value) {
    _$valueAtom.context.conditionallyRunInAction(() {
      super.value = value;
      _$valueAtom.reportChanged();
    }, _$valueAtom, name: '${_$valueAtom.name}_set');
  }

  final _$salvarAsyncAction = AsyncAction('salvar');

  @override
  Future salvar(
      {@required CgRefCodesController store,
      @required CgRefCodesListController storeCgRefCodesList}) {
    return _$salvarAsyncAction.run(() =>
        super.salvar(store: store, storeCgRefCodesList: storeCgRefCodesList));
  }

  final _$_CgRefCodesControllerBaseActionController =
      ActionController(name: '_CgRefCodesControllerBase');

  @override
  void increment() {
    final _$actionInfo =
        _$_CgRefCodesControllerBaseActionController.startAction();
    try {
      return super.increment();
    } finally {
      _$_CgRefCodesControllerBaseActionController.endAction(_$actionInfo);
    }
  }
}
