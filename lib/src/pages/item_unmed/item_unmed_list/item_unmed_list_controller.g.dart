// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_unmed_list_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ItemUnmedListController on _ItemUnmedListControllerBase, Store {
  Computed<bool> _$hasResultsItensUnmedComputed;

  @override
  bool get hasResultsItensUnmed => (_$hasResultsItensUnmedComputed ??=
          Computed<bool>(() => super.hasResultsItensUnmed))
      .value;

  final _$itensUnmedAtom =
      Atom(name: '_ItemUnmedListControllerBase.itensUnmed');

  @override
  List<ItemUnmed> get itensUnmed {
    _$itensUnmedAtom.context.enforceReadPolicy(_$itensUnmedAtom);
    _$itensUnmedAtom.reportObserved();
    return super.itensUnmed;
  }

  @override
  set itensUnmed(List<ItemUnmed> value) {
    _$itensUnmedAtom.context.conditionallyRunInAction(() {
      super.itensUnmed = value;
      _$itensUnmedAtom.reportChanged();
    }, _$itensUnmedAtom, name: '${_$itensUnmedAtom.name}_set');
  }

  final _$itensUnmedListAtom =
      Atom(name: '_ItemUnmedListControllerBase.itensUnmedList');

  @override
  ObservableFuture<List<ItemUnmed>> get itensUnmedList {
    _$itensUnmedListAtom.context.enforceReadPolicy(_$itensUnmedListAtom);
    _$itensUnmedListAtom.reportObserved();
    return super.itensUnmedList;
  }

  @override
  set itensUnmedList(ObservableFuture<List<ItemUnmed>> value) {
    _$itensUnmedListAtom.context.conditionallyRunInAction(() {
      super.itensUnmedList = value;
      _$itensUnmedListAtom.reportChanged();
    }, _$itensUnmedListAtom, name: '${_$itensUnmedListAtom.name}_set');
  }

  final _$listarAsyncAction = AsyncAction('listar');

  @override
  Future<List<ItemUnmed>> listar() {
    return _$listarAsyncAction.run(() => super.listar());
  }
}
