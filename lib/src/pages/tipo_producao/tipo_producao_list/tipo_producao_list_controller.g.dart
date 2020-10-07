// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tipo_producao_list_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TipoProducaoListController on _TipoProducaoListControllerBase, Store {
  Computed<bool> _$hasResultsTiposProducaoComputed;

  @override
  bool get hasResultsTiposProducao => (_$hasResultsTiposProducaoComputed ??=
          Computed<bool>(() => super.hasResultsTiposProducao))
      .value;

  final _$tiposProducaoAtom =
      Atom(name: '_TipoProducaoListControllerBase.tiposProducao');

  @override
  List<TipoProducao> get tiposProducao {
    _$tiposProducaoAtom.context.enforceReadPolicy(_$tiposProducaoAtom);
    _$tiposProducaoAtom.reportObserved();
    return super.tiposProducao;
  }

  @override
  set tiposProducao(List<TipoProducao> value) {
    _$tiposProducaoAtom.context.conditionallyRunInAction(() {
      super.tiposProducao = value;
      _$tiposProducaoAtom.reportChanged();
    }, _$tiposProducaoAtom, name: '${_$tiposProducaoAtom.name}_set');
  }

  final _$tiposProducaoListAtom =
      Atom(name: '_TipoProducaoListControllerBase.tiposProducaoList');

  @override
  ObservableFuture<List<TipoProducao>> get tiposProducaoList {
    _$tiposProducaoListAtom.context.enforceReadPolicy(_$tiposProducaoListAtom);
    _$tiposProducaoListAtom.reportObserved();
    return super.tiposProducaoList;
  }

  @override
  set tiposProducaoList(ObservableFuture<List<TipoProducao>> value) {
    _$tiposProducaoListAtom.context.conditionallyRunInAction(() {
      super.tiposProducaoList = value;
      _$tiposProducaoListAtom.reportChanged();
    }, _$tiposProducaoListAtom, name: '${_$tiposProducaoListAtom.name}_set');
  }

  final _$listarTiposProducaoAsyncAction = AsyncAction('listarTiposProducao');

  @override
  Future<List<TipoProducao>> listarTiposProducao() {
    return _$listarTiposProducaoAsyncAction
        .run(() => super.listarTiposProducao());
  }
}
