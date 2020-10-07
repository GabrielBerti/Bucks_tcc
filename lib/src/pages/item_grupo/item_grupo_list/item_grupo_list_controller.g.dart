// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_grupo_list_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ItemGrupoListController on _ItemGrupoListControllerBase, Store {
  Computed<bool> _$hasResultsItensGrupoComputed;

  @override
  bool get hasResultsItensGrupo => (_$hasResultsItensGrupoComputed ??=
          Computed<bool>(() => super.hasResultsItensGrupo))
      .value;

  final _$itensGrupoAtom =
      Atom(name: '_ItemGrupoListControllerBase.itensGrupo');

  @override
  List<ItemGrupo> get itensGrupo {
    _$itensGrupoAtom.context.enforceReadPolicy(_$itensGrupoAtom);
    _$itensGrupoAtom.reportObserved();
    return super.itensGrupo;
  }

  @override
  set itensGrupo(List<ItemGrupo> value) {
    _$itensGrupoAtom.context.conditionallyRunInAction(() {
      super.itensGrupo = value;
      _$itensGrupoAtom.reportChanged();
    }, _$itensGrupoAtom, name: '${_$itensGrupoAtom.name}_set');
  }

  final _$itensGrupoListAtom =
      Atom(name: '_ItemGrupoListControllerBase.itensGrupoList');

  @override
  ObservableFuture<List<ItemGrupo>> get itensGrupoList {
    _$itensGrupoListAtom.context.enforceReadPolicy(_$itensGrupoListAtom);
    _$itensGrupoListAtom.reportObserved();
    return super.itensGrupoList;
  }

  @override
  set itensGrupoList(ObservableFuture<List<ItemGrupo>> value) {
    _$itensGrupoListAtom.context.conditionallyRunInAction(() {
      super.itensGrupoList = value;
      _$itensGrupoListAtom.reportChanged();
    }, _$itensGrupoListAtom, name: '${_$itensGrupoListAtom.name}_set');
  }

  final _$listarItensGrupoAsyncAction = AsyncAction('listarItensGrupo');

  @override
  Future<List<ItemGrupo>> listarItensGrupo() {
    return _$listarItensGrupoAsyncAction.run(() => super.listarItensGrupo());
  }
}
