// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tipo_producao_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TipoProducaoController on _TipoProducaoControllerBase, Store {
  final _$idAtom = Atom(name: '_TipoProducaoControllerBase.id');

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

  final _$descrAtom = Atom(name: '_TipoProducaoControllerBase.descr');

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

  final _$salvarTipoProducaoAsyncAction = AsyncAction('salvarTipoProducao');

  @override
  Future salvarTipoProducao(
      {@required TipoProducaoController store,
      @required TipoProducaoListController storeTipoProducaoList}) {
    return _$salvarTipoProducaoAsyncAction.run(() => super.salvarTipoProducao(
        store: store, storeTipoProducaoList: storeTipoProducaoList));
  }

  final _$_TipoProducaoControllerBaseActionController =
      ActionController(name: '_TipoProducaoControllerBase');

  @override
  dynamic deletarTipoProducao({TipoProducao tipoProducao}) {
    final _$actionInfo =
        _$_TipoProducaoControllerBaseActionController.startAction();
    try {
      return super.deletarTipoProducao(tipoProducao: tipoProducao);
    } finally {
      _$_TipoProducaoControllerBaseActionController.endAction(_$actionInfo);
    }
  }
}
