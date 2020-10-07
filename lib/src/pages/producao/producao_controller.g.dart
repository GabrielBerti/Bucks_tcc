// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'producao_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProducaoController on _ProducaoControllerBase, Store {
  final _$ultProdInseridaAtom =
      Atom(name: '_ProducaoControllerBase.ultProdInserida');

  @override
  List<Producao> get ultProdInserida {
    _$ultProdInseridaAtom.context.enforceReadPolicy(_$ultProdInseridaAtom);
    _$ultProdInseridaAtom.reportObserved();
    return super.ultProdInserida;
  }

  @override
  set ultProdInserida(List<Producao> value) {
    _$ultProdInseridaAtom.context.conditionallyRunInAction(() {
      super.ultProdInserida = value;
      _$ultProdInseridaAtom.reportChanged();
    }, _$ultProdInseridaAtom, name: '${_$ultProdInseridaAtom.name}_set');
  }

  final _$idAtom = Atom(name: '_ProducaoControllerBase.id');

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

  final _$descrAtom = Atom(name: '_ProducaoControllerBase.descr');

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

  final _$vlMoAtom = Atom(name: '_ProducaoControllerBase.vlMo');

  @override
  TextEditingController get vlMo {
    _$vlMoAtom.context.enforceReadPolicy(_$vlMoAtom);
    _$vlMoAtom.reportObserved();
    return super.vlMo;
  }

  @override
  set vlMo(TextEditingController value) {
    _$vlMoAtom.context.conditionallyRunInAction(() {
      super.vlMo = value;
      _$vlMoAtom.reportChanged();
    }, _$vlMoAtom, name: '${_$vlMoAtom.name}_set');
  }

  final _$dtProducaoIniAtom =
      Atom(name: '_ProducaoControllerBase.dtProducaoIni');

  @override
  TextEditingController get dtProducaoIni {
    _$dtProducaoIniAtom.context.enforceReadPolicy(_$dtProducaoIniAtom);
    _$dtProducaoIniAtom.reportObserved();
    return super.dtProducaoIni;
  }

  @override
  set dtProducaoIni(TextEditingController value) {
    _$dtProducaoIniAtom.context.conditionallyRunInAction(() {
      super.dtProducaoIni = value;
      _$dtProducaoIniAtom.reportChanged();
    }, _$dtProducaoIniAtom, name: '${_$dtProducaoIniAtom.name}_set');
  }

  final _$dtProducaoFimAtom =
      Atom(name: '_ProducaoControllerBase.dtProducaoFim');

  @override
  TextEditingController get dtProducaoFim {
    _$dtProducaoFimAtom.context.enforceReadPolicy(_$dtProducaoFimAtom);
    _$dtProducaoFimAtom.reportObserved();
    return super.dtProducaoFim;
  }

  @override
  set dtProducaoFim(TextEditingController value) {
    _$dtProducaoFimAtom.context.conditionallyRunInAction(() {
      super.dtProducaoFim = value;
      _$dtProducaoFimAtom.reportChanged();
    }, _$dtProducaoFimAtom, name: '${_$dtProducaoFimAtom.name}_set');
  }

  final _$cdStatusAtom = Atom(name: '_ProducaoControllerBase.cdStatus');

  @override
  TextEditingController get cdStatus {
    _$cdStatusAtom.context.enforceReadPolicy(_$cdStatusAtom);
    _$cdStatusAtom.reportObserved();
    return super.cdStatus;
  }

  @override
  set cdStatus(TextEditingController value) {
    _$cdStatusAtom.context.conditionallyRunInAction(() {
      super.cdStatus = value;
      _$cdStatusAtom.reportChanged();
    }, _$cdStatusAtom, name: '${_$cdStatusAtom.name}_set');
  }

  final _$itemsEstoqueListAtom =
      Atom(name: '_ProducaoControllerBase.itemsEstoqueList');

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

  final _$initAsyncAction = AsyncAction('init');

  @override
  Future init() {
    return _$initAsyncAction.run(() => super.init());
  }

  final _$baixarProducaoAsyncAction = AsyncAction('baixarProducao');

  @override
  Future baixarProducao(
      {@required ProducaoController store,
      @required ProducaoListController storeProducaoList}) {
    return _$baixarProducaoAsyncAction.run(() => super
        .baixarProducao(store: store, storeProducaoList: storeProducaoList));
  }

  final _$salvarAsyncAction = AsyncAction('salvar');

  @override
  Future salvar(
      {@required ProducaoController store,
      @required ProducaoListController storeProducaoList}) {
    return _$salvarAsyncAction.run(
        () => super.salvar(store: store, storeProducaoList: storeProducaoList));
  }
}
