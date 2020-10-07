// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movto_estoque_tipo_list_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MovtoEstoqueTipoListController
    on _MovtoEstoqueTipoListControllerBase, Store {
  Computed<bool> _$hasResultsItensUnMedComputed;

  @override
  bool get hasResultsItensUnMed => (_$hasResultsItensUnMedComputed ??=
          Computed<bool>(() => super.hasResultsItensUnMed))
      .value;

  final _$movtosEstoqueTipoAtom =
      Atom(name: '_MovtoEstoqueTipoListControllerBase.movtosEstoqueTipo');

  @override
  List<MovtoEstoqueTipo> get movtosEstoqueTipo {
    _$movtosEstoqueTipoAtom.context.enforceReadPolicy(_$movtosEstoqueTipoAtom);
    _$movtosEstoqueTipoAtom.reportObserved();
    return super.movtosEstoqueTipo;
  }

  @override
  set movtosEstoqueTipo(List<MovtoEstoqueTipo> value) {
    _$movtosEstoqueTipoAtom.context.conditionallyRunInAction(() {
      super.movtosEstoqueTipo = value;
      _$movtosEstoqueTipoAtom.reportChanged();
    }, _$movtosEstoqueTipoAtom, name: '${_$movtosEstoqueTipoAtom.name}_set');
  }

  final _$movtosEstoqueTipoListAtom =
      Atom(name: '_MovtoEstoqueTipoListControllerBase.movtosEstoqueTipoList');

  @override
  ObservableFuture<List<MovtoEstoqueTipo>> get movtosEstoqueTipoList {
    _$movtosEstoqueTipoListAtom.context
        .enforceReadPolicy(_$movtosEstoqueTipoListAtom);
    _$movtosEstoqueTipoListAtom.reportObserved();
    return super.movtosEstoqueTipoList;
  }

  @override
  set movtosEstoqueTipoList(ObservableFuture<List<MovtoEstoqueTipo>> value) {
    _$movtosEstoqueTipoListAtom.context.conditionallyRunInAction(() {
      super.movtosEstoqueTipoList = value;
      _$movtosEstoqueTipoListAtom.reportChanged();
    }, _$movtosEstoqueTipoListAtom,
        name: '${_$movtosEstoqueTipoListAtom.name}_set');
  }

  final _$listarAsyncAction = AsyncAction('listar');

  @override
  Future<List<MovtoEstoqueTipo>> listar() {
    return _$listarAsyncAction.run(() => super.listar());
  }
}
