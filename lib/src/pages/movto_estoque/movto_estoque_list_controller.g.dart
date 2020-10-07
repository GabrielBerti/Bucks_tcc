// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movto_estoque_list_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MovtoEstoqueListController on _MovtoEstoqueListControllerBase, Store {
  Computed<bool> _$hasResultsComputed;

  @override
  bool get hasResults =>
      (_$hasResultsComputed ??= Computed<bool>(() => super.hasResults)).value;
  Computed<bool> _$hasResultsItemComputed;

  @override
  bool get hasResultsItem =>
      (_$hasResultsItemComputed ??= Computed<bool>(() => super.hasResultsItem))
          .value;
  Computed<bool> _$hasResultsItemEstoqueComputed;

  @override
  bool get hasResultsItemEstoque => (_$hasResultsItemEstoqueComputed ??=
          Computed<bool>(() => super.hasResultsItemEstoque))
      .value;
  Computed<bool> _$hasResultsMovtoTipoComputed;

  @override
  bool get hasResultsMovtoTipo => (_$hasResultsMovtoTipoComputed ??=
          Computed<bool>(() => super.hasResultsMovtoTipo))
      .value;

  final _$movtosEstoqueAtom =
      Atom(name: '_MovtoEstoqueListControllerBase.movtosEstoque');

  @override
  List<MovtoEstoque> get movtosEstoque {
    _$movtosEstoqueAtom.context.enforceReadPolicy(_$movtosEstoqueAtom);
    _$movtosEstoqueAtom.reportObserved();
    return super.movtosEstoque;
  }

  @override
  set movtosEstoque(List<MovtoEstoque> value) {
    _$movtosEstoqueAtom.context.conditionallyRunInAction(() {
      super.movtosEstoque = value;
      _$movtosEstoqueAtom.reportChanged();
    }, _$movtosEstoqueAtom, name: '${_$movtosEstoqueAtom.name}_set');
  }

  final _$lovItemEstoqueSelectedAtom =
      Atom(name: '_MovtoEstoqueListControllerBase.lovItemEstoqueSelected');

  @override
  ItemEstoque get lovItemEstoqueSelected {
    _$lovItemEstoqueSelectedAtom.context
        .enforceReadPolicy(_$lovItemEstoqueSelectedAtom);
    _$lovItemEstoqueSelectedAtom.reportObserved();
    return super.lovItemEstoqueSelected;
  }

  @override
  set lovItemEstoqueSelected(ItemEstoque value) {
    _$lovItemEstoqueSelectedAtom.context.conditionallyRunInAction(() {
      super.lovItemEstoqueSelected = value;
      _$lovItemEstoqueSelectedAtom.reportChanged();
    }, _$lovItemEstoqueSelectedAtom,
        name: '${_$lovItemEstoqueSelectedAtom.name}_set');
  }

  final _$lovMovtoEstoqueTipoSelectedAtom =
      Atom(name: '_MovtoEstoqueListControllerBase.lovMovtoEstoqueTipoSelected');

  @override
  MovtoEstoqueTipo get lovMovtoEstoqueTipoSelected {
    _$lovMovtoEstoqueTipoSelectedAtom.context
        .enforceReadPolicy(_$lovMovtoEstoqueTipoSelectedAtom);
    _$lovMovtoEstoqueTipoSelectedAtom.reportObserved();
    return super.lovMovtoEstoqueTipoSelected;
  }

  @override
  set lovMovtoEstoqueTipoSelected(MovtoEstoqueTipo value) {
    _$lovMovtoEstoqueTipoSelectedAtom.context.conditionallyRunInAction(() {
      super.lovMovtoEstoqueTipoSelected = value;
      _$lovMovtoEstoqueTipoSelectedAtom.reportChanged();
    }, _$lovMovtoEstoqueTipoSelectedAtom,
        name: '${_$lovMovtoEstoqueTipoSelectedAtom.name}_set');
  }

  final _$movtosEstoqueListAtom =
      Atom(name: '_MovtoEstoqueListControllerBase.movtosEstoqueList');

  @override
  ObservableFuture<List<MovtoEstoque>> get movtosEstoqueList {
    _$movtosEstoqueListAtom.context.enforceReadPolicy(_$movtosEstoqueListAtom);
    _$movtosEstoqueListAtom.reportObserved();
    return super.movtosEstoqueList;
  }

  @override
  set movtosEstoqueList(ObservableFuture<List<MovtoEstoque>> value) {
    _$movtosEstoqueListAtom.context.conditionallyRunInAction(() {
      super.movtosEstoqueList = value;
      _$movtosEstoqueListAtom.reportChanged();
    }, _$movtosEstoqueListAtom, name: '${_$movtosEstoqueListAtom.name}_set');
  }

  final _$itensListAtom =
      Atom(name: '_MovtoEstoqueListControllerBase.itensList');

  @override
  ObservableFuture<List<Item>> get itensList {
    _$itensListAtom.context.enforceReadPolicy(_$itensListAtom);
    _$itensListAtom.reportObserved();
    return super.itensList;
  }

  @override
  set itensList(ObservableFuture<List<Item>> value) {
    _$itensListAtom.context.conditionallyRunInAction(() {
      super.itensList = value;
      _$itensListAtom.reportChanged();
    }, _$itensListAtom, name: '${_$itensListAtom.name}_set');
  }

  final _$itensEstoqueListAtom =
      Atom(name: '_MovtoEstoqueListControllerBase.itensEstoqueList');

  @override
  ObservableFuture<List<ItemEstoque>> get itensEstoqueList {
    _$itensEstoqueListAtom.context.enforceReadPolicy(_$itensEstoqueListAtom);
    _$itensEstoqueListAtom.reportObserved();
    return super.itensEstoqueList;
  }

  @override
  set itensEstoqueList(ObservableFuture<List<ItemEstoque>> value) {
    _$itensEstoqueListAtom.context.conditionallyRunInAction(() {
      super.itensEstoqueList = value;
      _$itensEstoqueListAtom.reportChanged();
    }, _$itensEstoqueListAtom, name: '${_$itensEstoqueListAtom.name}_set');
  }

  final _$movtoTipoListAtom =
      Atom(name: '_MovtoEstoqueListControllerBase.movtoTipoList');

  @override
  ObservableFuture<List<MovtoEstoqueTipo>> get movtoTipoList {
    _$movtoTipoListAtom.context.enforceReadPolicy(_$movtoTipoListAtom);
    _$movtoTipoListAtom.reportObserved();
    return super.movtoTipoList;
  }

  @override
  set movtoTipoList(ObservableFuture<List<MovtoEstoqueTipo>> value) {
    _$movtoTipoListAtom.context.conditionallyRunInAction(() {
      super.movtoTipoList = value;
      _$movtoTipoListAtom.reportChanged();
    }, _$movtoTipoListAtom, name: '${_$movtoTipoListAtom.name}_set');
  }

  final _$validateDropDownsAsyncAction = AsyncAction('validateDropDowns');

  @override
  Future<String> validateDropDowns() {
    return _$validateDropDownsAsyncAction.run(() => super.validateDropDowns());
  }

  final _$listarAsyncAction = AsyncAction('listar');

  @override
  Future<List<MovtoEstoque>> listar() {
    return _$listarAsyncAction.run(() => super.listar());
  }

  final _$fetchItemAsyncAction = AsyncAction('fetchItem');

  @override
  Future<List<Item>> fetchItem() {
    return _$fetchItemAsyncAction.run(() => super.fetchItem());
  }

  final _$fetchItemEstoqueAsyncAction = AsyncAction('fetchItemEstoque');

  @override
  Future<List<ItemEstoque>> fetchItemEstoque() {
    return _$fetchItemEstoqueAsyncAction.run(() => super.fetchItemEstoque());
  }

  final _$fetchMovtoTipoAsyncAction = AsyncAction('fetchMovtoTipo');

  @override
  Future<List<MovtoEstoqueTipo>> fetchMovtoTipo() {
    return _$fetchMovtoTipoAsyncAction.run(() => super.fetchMovtoTipo());
  }

  final _$setItemEstoqueAsyncAction = AsyncAction('setItemEstoque');

  @override
  Future setItemEstoque(ItemEstoque model) {
    return _$setItemEstoqueAsyncAction.run(() => super.setItemEstoque(model));
  }

  final _$setMovtoEstoqueTipoAsyncAction = AsyncAction('setMovtoEstoqueTipo');

  @override
  Future setMovtoEstoqueTipo(MovtoEstoqueTipo model) {
    return _$setMovtoEstoqueTipoAsyncAction
        .run(() => super.setMovtoEstoqueTipo(model));
  }
}
