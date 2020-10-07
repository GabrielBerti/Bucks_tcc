// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_estoque_list_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ItemEstoqueListController on _ItemEstoqueListControllerBase, Store {
  Computed<bool> _$hasResultsComputed;

  @override
  bool get hasResults =>
      (_$hasResultsComputed ??= Computed<bool>(() => super.hasResults)).value;

  final _$itemsEstoqueAtom =
      Atom(name: '_ItemEstoqueListControllerBase.itemsEstoque');

  @override
  List<ItemEstoque> get itemsEstoque {
    _$itemsEstoqueAtom.context.enforceReadPolicy(_$itemsEstoqueAtom);
    _$itemsEstoqueAtom.reportObserved();
    return super.itemsEstoque;
  }

  @override
  set itemsEstoque(List<ItemEstoque> value) {
    _$itemsEstoqueAtom.context.conditionallyRunInAction(() {
      super.itemsEstoque = value;
      _$itemsEstoqueAtom.reportChanged();
    }, _$itemsEstoqueAtom, name: '${_$itemsEstoqueAtom.name}_set');
  }

  final _$itemsEstoqueListAtom =
      Atom(name: '_ItemEstoqueListControllerBase.itemsEstoqueList');

  @override
  ObservableFuture<List<ItemEstoque>> get itemsEstoqueList {
    _$itemsEstoqueListAtom.context.enforceReadPolicy(_$itemsEstoqueListAtom);
    _$itemsEstoqueListAtom.reportObserved();
    return super.itemsEstoqueList;
  }

  @override
  set itemsEstoqueList(ObservableFuture<List<ItemEstoque>> value) {
    _$itemsEstoqueListAtom.context.conditionallyRunInAction(() {
      super.itemsEstoqueList = value;
      _$itemsEstoqueListAtom.reportChanged();
    }, _$itemsEstoqueListAtom, name: '${_$itemsEstoqueListAtom.name}_set');
  }

  final _$findAllAsyncAction = AsyncAction('findAll');

  @override
  Future<List<ItemEstoque>> findAll() {
    return _$findAllAsyncAction.run(() => super.findAll());
  }

  final _$_ItemEstoqueListControllerBaseActionController =
      ActionController(name: '_ItemEstoqueListControllerBase');

  @override
  dynamic deletarItemEstoque({ItemEstoque itemEstoque}) {
    final _$actionInfo =
        _$_ItemEstoqueListControllerBaseActionController.startAction();
    try {
      return super.deletarItemEstoque(itemEstoque: itemEstoque);
    } finally {
      _$_ItemEstoqueListControllerBaseActionController.endAction(_$actionInfo);
    }
  }
}
