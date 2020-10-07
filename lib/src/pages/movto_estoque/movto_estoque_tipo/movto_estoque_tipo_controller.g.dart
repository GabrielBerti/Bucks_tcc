// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movto_estoque_tipo_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MovtoEstoqueTipoController on _MovtoEstoqueTipoControllerBase, Store {
  final _$tecIdAtom = Atom(name: '_MovtoEstoqueTipoControllerBase.tecId');

  @override
  TextEditingController get tecId {
    _$tecIdAtom.context.enforceReadPolicy(_$tecIdAtom);
    _$tecIdAtom.reportObserved();
    return super.tecId;
  }

  @override
  set tecId(TextEditingController value) {
    _$tecIdAtom.context.conditionallyRunInAction(() {
      super.tecId = value;
      _$tecIdAtom.reportChanged();
    }, _$tecIdAtom, name: '${_$tecIdAtom.name}_set');
  }

  final _$valueAtom = Atom(name: '_MovtoEstoqueTipoControllerBase.value');

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
      {@required MovtoEstoqueTipoController store,
      @required MovtoEstoqueTipoListController storeMovtoEstoqueTipoList}) {
    return _$salvarAsyncAction.run(() => super.salvar(
        store: store, storeMovtoEstoqueTipoList: storeMovtoEstoqueTipoList));
  }

  final _$_MovtoEstoqueTipoControllerBaseActionController =
      ActionController(name: '_MovtoEstoqueTipoControllerBase');

  @override
  dynamic deletarMovtoEstoqueTipo({MovtoEstoqueTipo movtoEstoqueTipo}) {
    final _$actionInfo =
        _$_MovtoEstoqueTipoControllerBaseActionController.startAction();
    try {
      return super.deletarMovtoEstoqueTipo(movtoEstoqueTipo: movtoEstoqueTipo);
    } finally {
      _$_MovtoEstoqueTipoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void increment() {
    final _$actionInfo =
        _$_MovtoEstoqueTipoControllerBaseActionController.startAction();
    try {
      return super.increment();
    } finally {
      _$_MovtoEstoqueTipoControllerBaseActionController.endAction(_$actionInfo);
    }
  }
}
