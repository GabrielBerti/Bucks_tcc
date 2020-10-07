// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_tipo_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ItemTipoController on _ItemTipoControllerBase, Store {
  final _$idAtom = Atom(name: '_ItemTipoControllerBase.id');

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

  final _$descrAtom = Atom(name: '_ItemTipoControllerBase.descr');

  @override
  TextEditingController get descr {
    _$descrAtom.context.enforceReadPolicy(_$descrAtom);
    _$descrAtom.reportObserved();
    return super.descr;
  }

  @override
  set descr(TextEditingController value) {
    _$descrAtom.context.conditionallyRunInAction(() {
      super.descr = value;
      _$descrAtom.reportChanged();
    }, _$descrAtom, name: '${_$descrAtom.name}_set');
  }

  final _$valueAtom = Atom(name: '_ItemTipoControllerBase.value');

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

  final _$salvarItemTipoAsyncAction = AsyncAction('salvarItemTipo');

  @override
  Future salvarItemTipo(
      {@required ItemTipoController store,
      @required ItemTipoListController storeItemTipoList}) {
    return _$salvarItemTipoAsyncAction.run(() => super
        .salvarItemTipo(store: store, storeItemTipoList: storeItemTipoList));
  }

  final _$_ItemTipoControllerBaseActionController =
      ActionController(name: '_ItemTipoControllerBase');

  @override
  dynamic deletarItemTipo({ItemTipo itemTipo}) {
    final _$actionInfo =
        _$_ItemTipoControllerBaseActionController.startAction();
    try {
      return super.deletarItemTipo(itemTipo: itemTipo);
    } finally {
      _$_ItemTipoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void increment() {
    final _$actionInfo =
        _$_ItemTipoControllerBaseActionController.startAction();
    try {
      return super.increment();
    } finally {
      _$_ItemTipoControllerBaseActionController.endAction(_$actionInfo);
    }
  }
}
