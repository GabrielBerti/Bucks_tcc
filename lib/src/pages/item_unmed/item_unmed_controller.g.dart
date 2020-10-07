// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_unmed_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ItemUnmedController on _ItemUnmedControllerBase, Store {
  final _$idAtom = Atom(name: '_ItemUnmedControllerBase.id');

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

  final _$valueAtom = Atom(name: '_ItemUnmedControllerBase.value');

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
      {@required ItemUnmedController store,
      @required ItemUnmedListController storeItemUnmedList}) {
    return _$salvarAsyncAction.run(() =>
        super.salvar(store: store, storeItemUnmedList: storeItemUnmedList));
  }

  final _$_ItemUnmedControllerBaseActionController =
      ActionController(name: '_ItemUnmedControllerBase');

  @override
  dynamic deletarItemUnmed({ItemUnmed itemUnmed}) {
    final _$actionInfo =
        _$_ItemUnmedControllerBaseActionController.startAction();
    try {
      return super.deletarItemUnmed(itemUnmed: itemUnmed);
    } finally {
      _$_ItemUnmedControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void increment() {
    final _$actionInfo =
        _$_ItemUnmedControllerBaseActionController.startAction();
    try {
      return super.increment();
    } finally {
      _$_ItemUnmedControllerBaseActionController.endAction(_$actionInfo);
    }
  }
}
