// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_tipo_list_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ItemTipoListController on _ItemTipoListControllerBase, Store {
  Computed<bool> _$hasResultsItensTipoComputed;

  @override
  bool get hasResultsItensTipo => (_$hasResultsItensTipoComputed ??=
          Computed<bool>(() => super.hasResultsItensTipo))
      .value;

  final _$itensTipoAtom = Atom(name: '_ItemTipoListControllerBase.itensTipo');

  @override
  List<ItemTipo> get itensTipo {
    _$itensTipoAtom.context.enforceReadPolicy(_$itensTipoAtom);
    _$itensTipoAtom.reportObserved();
    return super.itensTipo;
  }

  @override
  set itensTipo(List<ItemTipo> value) {
    _$itensTipoAtom.context.conditionallyRunInAction(() {
      super.itensTipo = value;
      _$itensTipoAtom.reportChanged();
    }, _$itensTipoAtom, name: '${_$itensTipoAtom.name}_set');
  }

  final _$itensTipoListAtom =
      Atom(name: '_ItemTipoListControllerBase.itensTipoList');

  @override
  ObservableFuture<List<ItemTipo>> get itensTipoList {
    _$itensTipoListAtom.context.enforceReadPolicy(_$itensTipoListAtom);
    _$itensTipoListAtom.reportObserved();
    return super.itensTipoList;
  }

  @override
  set itensTipoList(ObservableFuture<List<ItemTipo>> value) {
    _$itensTipoListAtom.context.conditionallyRunInAction(() {
      super.itensTipoList = value;
      _$itensTipoListAtom.reportChanged();
    }, _$itensTipoListAtom, name: '${_$itensTipoListAtom.name}_set');
  }

  final _$listarItensTipoAsyncAction = AsyncAction('listarItensTipo');

  @override
  Future<List<ItemTipo>> listarItensTipo() {
    return _$listarItensTipoAsyncAction.run(() => super.listarItensTipo());
  }
}
