// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'producao_list_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProducaoListController on _ProducaoListControllerBase, Store {
  Computed<bool> _$hasResultsItemEstoqueComputed;

  @override
  bool get hasResultsItemEstoque => (_$hasResultsItemEstoqueComputed ??=
          Computed<bool>(() => super.hasResultsItemEstoque))
      .value;
  Computed<bool> _$hasResultsItemComputed;

  @override
  bool get hasResultsItem =>
      (_$hasResultsItemComputed ??= Computed<bool>(() => super.hasResultsItem))
          .value;
  Computed<bool> _$hasResultsProducaoComputed;

  @override
  bool get hasResultsProducao => (_$hasResultsProducaoComputed ??=
          Computed<bool>(() => super.hasResultsProducao))
      .value;
  Computed<bool> _$hasResultsProducaoItemDtComputed;

  @override
  bool get hasResultsProducaoItemDt => (_$hasResultsProducaoItemDtComputed ??=
          Computed<bool>(() => super.hasResultsProducaoItemDt))
      .value;
  Computed<bool> _$hasResultsProducaoItemDtNovoEntradaComputed;

  @override
  bool get hasResultsProducaoItemDtNovoEntrada =>
      (_$hasResultsProducaoItemDtNovoEntradaComputed ??=
              Computed<bool>(() => super.hasResultsProducaoItemDtNovoEntrada))
          .value;
  Computed<bool> _$hasResultsProducaoItemDtSemEstComputed;

  @override
  bool get hasResultsProducaoItemDtSemEst =>
      (_$hasResultsProducaoItemDtSemEstComputed ??=
              Computed<bool>(() => super.hasResultsProducaoItemDtSemEst))
          .value;
  Computed<bool> _$hasResultsProducaoItemComputed;

  @override
  bool get hasResultsProducaoItem => (_$hasResultsProducaoItemComputed ??=
          Computed<bool>(() => super.hasResultsProducaoItem))
      .value;
  Computed<bool> _$hasResultsItemEstoqueEntradaComputed;

  @override
  bool get hasResultsItemEstoqueEntrada =>
      (_$hasResultsItemEstoqueEntradaComputed ??=
              Computed<bool>(() => super.hasResultsItemEstoqueEntrada))
          .value;
  Computed<bool> _$hasResultsItemSaidaComputed;

  @override
  bool get hasResultsItemSaida => (_$hasResultsItemSaidaComputed ??=
          Computed<bool>(() => super.hasResultsItemSaida))
      .value;
  Computed<bool> _$hasResultsTipoProducaoComputed;

  @override
  bool get hasResultsTipoProducao => (_$hasResultsTipoProducaoComputed ??=
          Computed<bool>(() => super.hasResultsTipoProducao))
      .value;
  Computed<bool> _$hasResultsItemIndiretoComputed;

  @override
  bool get hasResultsItemIndireto => (_$hasResultsItemIndiretoComputed ??=
          Computed<bool>(() => super.hasResultsItemIndireto))
      .value;

  final _$producoesAtom = Atom(name: '_ProducaoListControllerBase.producoes');

  @override
  List<Producao> get producoes {
    _$producoesAtom.context.enforceReadPolicy(_$producoesAtom);
    _$producoesAtom.reportObserved();
    return super.producoes;
  }

  @override
  set producoes(List<Producao> value) {
    _$producoesAtom.context.conditionallyRunInAction(() {
      super.producoes = value;
      _$producoesAtom.reportChanged();
    }, _$producoesAtom, name: '${_$producoesAtom.name}_set');
  }

  final _$producaoItensDtAtom =
      Atom(name: '_ProducaoListControllerBase.producaoItensDt');

  @override
  List<ProducaoItem> get producaoItensDt {
    _$producaoItensDtAtom.context.enforceReadPolicy(_$producaoItensDtAtom);
    _$producaoItensDtAtom.reportObserved();
    return super.producaoItensDt;
  }

  @override
  set producaoItensDt(List<ProducaoItem> value) {
    _$producaoItensDtAtom.context.conditionallyRunInAction(() {
      super.producaoItensDt = value;
      _$producaoItensDtAtom.reportChanged();
    }, _$producaoItensDtAtom, name: '${_$producaoItensDtAtom.name}_set');
  }

  final _$producaoItensDtNovoEntradaAtom =
      Atom(name: '_ProducaoListControllerBase.producaoItensDtNovoEntrada');

  @override
  List<ProducaoItem> get producaoItensDtNovoEntrada {
    _$producaoItensDtNovoEntradaAtom.context
        .enforceReadPolicy(_$producaoItensDtNovoEntradaAtom);
    _$producaoItensDtNovoEntradaAtom.reportObserved();
    return super.producaoItensDtNovoEntrada;
  }

  @override
  set producaoItensDtNovoEntrada(List<ProducaoItem> value) {
    _$producaoItensDtNovoEntradaAtom.context.conditionallyRunInAction(() {
      super.producaoItensDtNovoEntrada = value;
      _$producaoItensDtNovoEntradaAtom.reportChanged();
    }, _$producaoItensDtNovoEntradaAtom,
        name: '${_$producaoItensDtNovoEntradaAtom.name}_set');
  }

  final _$producaoItensDtSaidaAtom =
      Atom(name: '_ProducaoListControllerBase.producaoItensDtSaida');

  @override
  List<ProducaoItem> get producaoItensDtSaida {
    _$producaoItensDtSaidaAtom.context
        .enforceReadPolicy(_$producaoItensDtSaidaAtom);
    _$producaoItensDtSaidaAtom.reportObserved();
    return super.producaoItensDtSaida;
  }

  @override
  set producaoItensDtSaida(List<ProducaoItem> value) {
    _$producaoItensDtSaidaAtom.context.conditionallyRunInAction(() {
      super.producaoItensDtSaida = value;
      _$producaoItensDtSaidaAtom.reportChanged();
    }, _$producaoItensDtSaidaAtom,
        name: '${_$producaoItensDtSaidaAtom.name}_set');
  }

  final _$producaoItensIndiretosDtAtom =
      Atom(name: '_ProducaoListControllerBase.producaoItensIndiretosDt');

  @override
  List<ProducaoItem> get producaoItensIndiretosDt {
    _$producaoItensIndiretosDtAtom.context
        .enforceReadPolicy(_$producaoItensIndiretosDtAtom);
    _$producaoItensIndiretosDtAtom.reportObserved();
    return super.producaoItensIndiretosDt;
  }

  @override
  set producaoItensIndiretosDt(List<ProducaoItem> value) {
    _$producaoItensIndiretosDtAtom.context.conditionallyRunInAction(() {
      super.producaoItensIndiretosDt = value;
      _$producaoItensIndiretosDtAtom.reportChanged();
    }, _$producaoItensIndiretosDtAtom,
        name: '${_$producaoItensIndiretosDtAtom.name}_set');
  }

  final _$itemsEstoqueEntradaAtom =
      Atom(name: '_ProducaoListControllerBase.itemsEstoqueEntrada');

  @override
  List<ItemEstoque> get itemsEstoqueEntrada {
    _$itemsEstoqueEntradaAtom.context
        .enforceReadPolicy(_$itemsEstoqueEntradaAtom);
    _$itemsEstoqueEntradaAtom.reportObserved();
    return super.itemsEstoqueEntrada;
  }

  @override
  set itemsEstoqueEntrada(List<ItemEstoque> value) {
    _$itemsEstoqueEntradaAtom.context.conditionallyRunInAction(() {
      super.itemsEstoqueEntrada = value;
      _$itemsEstoqueEntradaAtom.reportChanged();
    }, _$itemsEstoqueEntradaAtom,
        name: '${_$itemsEstoqueEntradaAtom.name}_set');
  }

  final _$itemsSaidaAtom = Atom(name: '_ProducaoListControllerBase.itemsSaida');

  @override
  List<ItemEstoque> get itemsSaida {
    _$itemsSaidaAtom.context.enforceReadPolicy(_$itemsSaidaAtom);
    _$itemsSaidaAtom.reportObserved();
    return super.itemsSaida;
  }

  @override
  set itemsSaida(List<ItemEstoque> value) {
    _$itemsSaidaAtom.context.conditionallyRunInAction(() {
      super.itemsSaida = value;
      _$itemsSaidaAtom.reportChanged();
    }, _$itemsSaidaAtom, name: '${_$itemsSaidaAtom.name}_set');
  }

  final _$tiposProducaoAtom =
      Atom(name: '_ProducaoListControllerBase.tiposProducao');

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

  final _$itemsIndiretosAtom =
      Atom(name: '_ProducaoListControllerBase.itemsIndiretos');

  @override
  List<Item> get itemsIndiretos {
    _$itemsIndiretosAtom.context.enforceReadPolicy(_$itemsIndiretosAtom);
    _$itemsIndiretosAtom.reportObserved();
    return super.itemsIndiretos;
  }

  @override
  set itemsIndiretos(List<Item> value) {
    _$itemsIndiretosAtom.context.conditionallyRunInAction(() {
      super.itemsIndiretos = value;
      _$itemsIndiretosAtom.reportChanged();
    }, _$itemsIndiretosAtom, name: '${_$itemsIndiretosAtom.name}_set');
  }

  final _$ultProdInseridaAtom =
      Atom(name: '_ProducaoListControllerBase.ultProdInserida');

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

  final _$itemEstoqueEntradaAtom =
      Atom(name: '_ProducaoListControllerBase.itemEstoqueEntrada');

  @override
  ItemEstoque get itemEstoqueEntrada {
    _$itemEstoqueEntradaAtom.context
        .enforceReadPolicy(_$itemEstoqueEntradaAtom);
    _$itemEstoqueEntradaAtom.reportObserved();
    return super.itemEstoqueEntrada;
  }

  @override
  set itemEstoqueEntrada(ItemEstoque value) {
    _$itemEstoqueEntradaAtom.context.conditionallyRunInAction(() {
      super.itemEstoqueEntrada = value;
      _$itemEstoqueEntradaAtom.reportChanged();
    }, _$itemEstoqueEntradaAtom, name: '${_$itemEstoqueEntradaAtom.name}_set');
  }

  final _$itemSaidaAtom = Atom(name: '_ProducaoListControllerBase.itemSaida');

  @override
  ItemEstoque get itemSaida {
    _$itemSaidaAtom.context.enforceReadPolicy(_$itemSaidaAtom);
    _$itemSaidaAtom.reportObserved();
    return super.itemSaida;
  }

  @override
  set itemSaida(ItemEstoque value) {
    _$itemSaidaAtom.context.conditionallyRunInAction(() {
      super.itemSaida = value;
      _$itemSaidaAtom.reportChanged();
    }, _$itemSaidaAtom, name: '${_$itemSaidaAtom.name}_set');
  }

  final _$itemIndiretoAtom =
      Atom(name: '_ProducaoListControllerBase.itemIndireto');

  @override
  Item get itemIndireto {
    _$itemIndiretoAtom.context.enforceReadPolicy(_$itemIndiretoAtom);
    _$itemIndiretoAtom.reportObserved();
    return super.itemIndireto;
  }

  @override
  set itemIndireto(Item value) {
    _$itemIndiretoAtom.context.conditionallyRunInAction(() {
      super.itemIndireto = value;
      _$itemIndiretoAtom.reportChanged();
    }, _$itemIndiretoAtom, name: '${_$itemIndiretoAtom.name}_set');
  }

  final _$tipoProducaoAtom =
      Atom(name: '_ProducaoListControllerBase.tipoProducao');

  @override
  TipoProducao get tipoProducao {
    _$tipoProducaoAtom.context.enforceReadPolicy(_$tipoProducaoAtom);
    _$tipoProducaoAtom.reportObserved();
    return super.tipoProducao;
  }

  @override
  set tipoProducao(TipoProducao value) {
    _$tipoProducaoAtom.context.conditionallyRunInAction(() {
      super.tipoProducao = value;
      _$tipoProducaoAtom.reportChanged();
    }, _$tipoProducaoAtom, name: '${_$tipoProducaoAtom.name}_set');
  }

  final _$producaoItemAtom =
      Atom(name: '_ProducaoListControllerBase.producaoItem');

  @override
  ProducaoItem get producaoItem {
    _$producaoItemAtom.context.enforceReadPolicy(_$producaoItemAtom);
    _$producaoItemAtom.reportObserved();
    return super.producaoItem;
  }

  @override
  set producaoItem(ProducaoItem value) {
    _$producaoItemAtom.context.conditionallyRunInAction(() {
      super.producaoItem = value;
      _$producaoItemAtom.reportChanged();
    }, _$producaoItemAtom, name: '${_$producaoItemAtom.name}_set');
  }

  final _$producaoAtom = Atom(name: '_ProducaoListControllerBase.producao');

  @override
  Producao get producao {
    _$producaoAtom.context.enforceReadPolicy(_$producaoAtom);
    _$producaoAtom.reportObserved();
    return super.producao;
  }

  @override
  set producao(Producao value) {
    _$producaoAtom.context.conditionallyRunInAction(() {
      super.producao = value;
      _$producaoAtom.reportChanged();
    }, _$producaoAtom, name: '${_$producaoAtom.name}_set');
  }

  final _$tipoProducaoListAlteracaoAtom =
      Atom(name: '_ProducaoListControllerBase.tipoProducaoListAlteracao');

  @override
  ObservableFuture<List<TipoProducao>> get tipoProducaoListAlteracao {
    _$tipoProducaoListAlteracaoAtom.context
        .enforceReadPolicy(_$tipoProducaoListAlteracaoAtom);
    _$tipoProducaoListAlteracaoAtom.reportObserved();
    return super.tipoProducaoListAlteracao;
  }

  @override
  set tipoProducaoListAlteracao(ObservableFuture<List<TipoProducao>> value) {
    _$tipoProducaoListAlteracaoAtom.context.conditionallyRunInAction(() {
      super.tipoProducaoListAlteracao = value;
      _$tipoProducaoListAlteracaoAtom.reportChanged();
    }, _$tipoProducaoListAlteracaoAtom,
        name: '${_$tipoProducaoListAlteracaoAtom.name}_set');
  }

  final _$itensEstoqueListAtom =
      Atom(name: '_ProducaoListControllerBase.itensEstoqueList');

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

  final _$itensListAtom = Atom(name: '_ProducaoListControllerBase.itensList');

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

  final _$producoesListAtom =
      Atom(name: '_ProducaoListControllerBase.producoesList');

  @override
  ObservableFuture<List<Producao>> get producoesList {
    _$producoesListAtom.context.enforceReadPolicy(_$producoesListAtom);
    _$producoesListAtom.reportObserved();
    return super.producoesList;
  }

  @override
  set producoesList(ObservableFuture<List<Producao>> value) {
    _$producoesListAtom.context.conditionallyRunInAction(() {
      super.producoesList = value;
      _$producoesListAtom.reportChanged();
    }, _$producoesListAtom, name: '${_$producoesListAtom.name}_set');
  }

  final _$producaoItemListDtAtom =
      Atom(name: '_ProducaoListControllerBase.producaoItemListDt');

  @override
  ObservableFuture<List<ProducaoItem>> get producaoItemListDt {
    _$producaoItemListDtAtom.context
        .enforceReadPolicy(_$producaoItemListDtAtom);
    _$producaoItemListDtAtom.reportObserved();
    return super.producaoItemListDt;
  }

  @override
  set producaoItemListDt(ObservableFuture<List<ProducaoItem>> value) {
    _$producaoItemListDtAtom.context.conditionallyRunInAction(() {
      super.producaoItemListDt = value;
      _$producaoItemListDtAtom.reportChanged();
    }, _$producaoItemListDtAtom, name: '${_$producaoItemListDtAtom.name}_set');
  }

  final _$producaoItemListAtom =
      Atom(name: '_ProducaoListControllerBase.producaoItemList');

  @override
  ObservableFuture<List<ProducaoItem>> get producaoItemList {
    _$producaoItemListAtom.context.enforceReadPolicy(_$producaoItemListAtom);
    _$producaoItemListAtom.reportObserved();
    return super.producaoItemList;
  }

  @override
  set producaoItemList(ObservableFuture<List<ProducaoItem>> value) {
    _$producaoItemListAtom.context.conditionallyRunInAction(() {
      super.producaoItemList = value;
      _$producaoItemListAtom.reportChanged();
    }, _$producaoItemListAtom, name: '${_$producaoItemListAtom.name}_set');
  }

  final _$producaoItemNovoEntradaListAtom =
      Atom(name: '_ProducaoListControllerBase.producaoItemNovoEntradaList');

  @override
  ObservableFuture<List<ProducaoItem>> get producaoItemNovoEntradaList {
    _$producaoItemNovoEntradaListAtom.context
        .enforceReadPolicy(_$producaoItemNovoEntradaListAtom);
    _$producaoItemNovoEntradaListAtom.reportObserved();
    return super.producaoItemNovoEntradaList;
  }

  @override
  set producaoItemNovoEntradaList(ObservableFuture<List<ProducaoItem>> value) {
    _$producaoItemNovoEntradaListAtom.context.conditionallyRunInAction(() {
      super.producaoItemNovoEntradaList = value;
      _$producaoItemNovoEntradaListAtom.reportChanged();
    }, _$producaoItemNovoEntradaListAtom,
        name: '${_$producaoItemNovoEntradaListAtom.name}_set');
  }

  final _$producaoItemSemEstListAtom =
      Atom(name: '_ProducaoListControllerBase.producaoItemSemEstList');

  @override
  ObservableFuture<List<ProducaoItem>> get producaoItemSemEstList {
    _$producaoItemSemEstListAtom.context
        .enforceReadPolicy(_$producaoItemSemEstListAtom);
    _$producaoItemSemEstListAtom.reportObserved();
    return super.producaoItemSemEstList;
  }

  @override
  set producaoItemSemEstList(ObservableFuture<List<ProducaoItem>> value) {
    _$producaoItemSemEstListAtom.context.conditionallyRunInAction(() {
      super.producaoItemSemEstList = value;
      _$producaoItemSemEstListAtom.reportChanged();
    }, _$producaoItemSemEstListAtom,
        name: '${_$producaoItemSemEstListAtom.name}_set');
  }

  final _$itemEstoqueEntradaListAtom =
      Atom(name: '_ProducaoListControllerBase.itemEstoqueEntradaList');

  @override
  ObservableFuture<List<ItemEstoque>> get itemEstoqueEntradaList {
    _$itemEstoqueEntradaListAtom.context
        .enforceReadPolicy(_$itemEstoqueEntradaListAtom);
    _$itemEstoqueEntradaListAtom.reportObserved();
    return super.itemEstoqueEntradaList;
  }

  @override
  set itemEstoqueEntradaList(ObservableFuture<List<ItemEstoque>> value) {
    _$itemEstoqueEntradaListAtom.context.conditionallyRunInAction(() {
      super.itemEstoqueEntradaList = value;
      _$itemEstoqueEntradaListAtom.reportChanged();
    }, _$itemEstoqueEntradaListAtom,
        name: '${_$itemEstoqueEntradaListAtom.name}_set');
  }

  final _$itemSaidaListAtom =
      Atom(name: '_ProducaoListControllerBase.itemSaidaList');

  @override
  ObservableFuture<List<ItemEstoque>> get itemSaidaList {
    _$itemSaidaListAtom.context.enforceReadPolicy(_$itemSaidaListAtom);
    _$itemSaidaListAtom.reportObserved();
    return super.itemSaidaList;
  }

  @override
  set itemSaidaList(ObservableFuture<List<ItemEstoque>> value) {
    _$itemSaidaListAtom.context.conditionallyRunInAction(() {
      super.itemSaidaList = value;
      _$itemSaidaListAtom.reportChanged();
    }, _$itemSaidaListAtom, name: '${_$itemSaidaListAtom.name}_set');
  }

  final _$tipoProducaoListAtom =
      Atom(name: '_ProducaoListControllerBase.tipoProducaoList');

  @override
  ObservableFuture<List<TipoProducao>> get tipoProducaoList {
    _$tipoProducaoListAtom.context.enforceReadPolicy(_$tipoProducaoListAtom);
    _$tipoProducaoListAtom.reportObserved();
    return super.tipoProducaoList;
  }

  @override
  set tipoProducaoList(ObservableFuture<List<TipoProducao>> value) {
    _$tipoProducaoListAtom.context.conditionallyRunInAction(() {
      super.tipoProducaoList = value;
      _$tipoProducaoListAtom.reportChanged();
    }, _$tipoProducaoListAtom, name: '${_$tipoProducaoListAtom.name}_set');
  }

  final _$itemIndiretoListAtom =
      Atom(name: '_ProducaoListControllerBase.itemIndiretoList');

  @override
  ObservableFuture<List<Item>> get itemIndiretoList {
    _$itemIndiretoListAtom.context.enforceReadPolicy(_$itemIndiretoListAtom);
    _$itemIndiretoListAtom.reportObserved();
    return super.itemIndiretoList;
  }

  @override
  set itemIndiretoList(ObservableFuture<List<Item>> value) {
    _$itemIndiretoListAtom.context.conditionallyRunInAction(() {
      super.itemIndiretoList = value;
      _$itemIndiretoListAtom.reportChanged();
    }, _$itemIndiretoListAtom, name: '${_$itemIndiretoListAtom.name}_set');
  }

  final _$listarItemEstoqueAsyncAction = AsyncAction('listarItemEstoque');

  @override
  Future<List<ItemEstoque>> listarItemEstoque() {
    return _$listarItemEstoqueAsyncAction.run(() => super.listarItemEstoque());
  }

  final _$listarItemSaidaAsyncAction = AsyncAction('listarItemSaida');

  @override
  Future<List<ItemEstoque>> listarItemSaida() {
    return _$listarItemSaidaAsyncAction.run(() => super.listarItemSaida());
  }

  final _$listarItemIndiretoAsyncAction = AsyncAction('listarItemIndireto');

  @override
  Future<List<Item>> listarItemIndireto() {
    return _$listarItemIndiretoAsyncAction
        .run(() => super.listarItemIndireto());
  }

  final _$listarTipoProducaoAsyncAction = AsyncAction('listarTipoProducao');

  @override
  Future<List<TipoProducao>> listarTipoProducao() {
    return _$listarTipoProducaoAsyncAction
        .run(() => super.listarTipoProducao());
  }

  final _$listarProducaoItemAsyncAction = AsyncAction('listarProducaoItem');

  @override
  Future<List<ProducaoItem>> listarProducaoItem(Producao producao) {
    return _$listarProducaoItemAsyncAction
        .run(() => super.listarProducaoItem(producao));
  }

  final _$listarProducaoByIdAsyncAction = AsyncAction('listarProducaoById');

  @override
  Future<List<Producao>> listarProducaoById(int id) {
    return _$listarProducaoByIdAsyncAction
        .run(() => super.listarProducaoById(id));
  }

  final _$setLixoAsyncAction = AsyncAction('setLixo');

  @override
  Future setLixo() {
    return _$setLixoAsyncAction.run(() => super.setLixo());
  }

  final _$setTipoProducaoAsyncAction = AsyncAction('setTipoProducao');

  @override
  Future setTipoProducao(TipoProducao model) {
    return _$setTipoProducaoAsyncAction.run(() => super.setTipoProducao(model));
  }

  final _$salvarProducaoItemAsyncAction = AsyncAction('salvarProducaoItem');

  @override
  Future salvarProducaoItem({ProducaoItem producaoItem, Producao producao}) {
    return _$salvarProducaoItemAsyncAction.run(() => super
        .salvarProducaoItem(producaoItem: producaoItem, producao: producao));
  }

  final _$setProducaoItemEstoqueEntradaAsyncAction =
      AsyncAction('setProducaoItemEstoqueEntrada');

  @override
  Future setProducaoItemEstoqueEntrada(ItemEstoque model, Producao producao) {
    return _$setProducaoItemEstoqueEntradaAsyncAction
        .run(() => super.setProducaoItemEstoqueEntrada(model, producao));
  }

  final _$setProducaoItemSaidaAsyncAction = AsyncAction('setProducaoItemSaida');

  @override
  Future setProducaoItemSaida(ItemEstoque model, Producao producao) {
    return _$setProducaoItemSaidaAsyncAction
        .run(() => super.setProducaoItemSaida(model, producao));
  }

  final _$setProducaoItemIndiretoAsyncAction =
      AsyncAction('setProducaoItemIndireto');

  @override
  Future setProducaoItemIndireto(Item model, Producao producao) {
    return _$setProducaoItemIndiretoAsyncAction
        .run(() => super.setProducaoItemIndireto(model, producao));
  }

  final _$listarAsyncAction = AsyncAction('listar');

  @override
  Future<List<Producao>> listar() {
    return _$listarAsyncAction.run(() => super.listar());
  }

  final _$removeProdItemDataTableAsyncAction =
      AsyncAction('removeProdItemDataTable');

  @override
  Future removeProdItemDataTable(ProducaoItem data) {
    return _$removeProdItemDataTableAsyncAction
        .run(() => super.removeProdItemDataTable(data));
  }

  final _$removeitemsDataTableEntradaAsyncAction =
      AsyncAction('removeitemsDataTableEntrada');

  @override
  Future removeitemsDataTableEntrada(ProducaoItem data) {
    return _$removeitemsDataTableEntradaAsyncAction
        .run(() => super.removeitemsDataTableEntrada(data));
  }

  final _$removeitemsDtSaidaAsyncAction = AsyncAction('removeitemsDtSaida');

  @override
  Future removeitemsDtSaida(ProducaoItem data) {
    return _$removeitemsDtSaidaAsyncAction
        .run(() => super.removeitemsDtSaida(data));
  }

  final _$removeitemsIndiretosDtAsyncAction =
      AsyncAction('removeitemsIndiretosDt');

  @override
  Future removeitemsIndiretosDt(ProducaoItem data) {
    return _$removeitemsIndiretosDtAsyncAction
        .run(() => super.removeitemsIndiretosDt(data));
  }

  final _$_ProducaoListControllerBaseActionController =
      ActionController(name: '_ProducaoListControllerBase');

  @override
  dynamic deletarProducaoItem({ProducaoItem producaoItem}) {
    final _$actionInfo =
        _$_ProducaoListControllerBaseActionController.startAction();
    try {
      return super.deletarProducaoItem(producaoItem: producaoItem);
    } finally {
      _$_ProducaoListControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  bool validaDataTableItemSaidaPossuiItem(ItemEstoque item) {
    final _$actionInfo =
        _$_ProducaoListControllerBaseActionController.startAction();
    try {
      return super.validaDataTableItemSaidaPossuiItem(item);
    } finally {
      _$_ProducaoListControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  bool validaDataTableItemIndiretoPossuiItem(Item item) {
    final _$actionInfo =
        _$_ProducaoListControllerBaseActionController.startAction();
    try {
      return super.validaDataTableItemIndiretoPossuiItem(item);
    } finally {
      _$_ProducaoListControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  bool validaDataTableEntradaPossuiItem(ItemEstoque item) {
    final _$actionInfo =
        _$_ProducaoListControllerBaseActionController.startAction();
    try {
      return super.validaDataTableEntradaPossuiItem(item);
    } finally {
      _$_ProducaoListControllerBaseActionController.endAction(_$actionInfo);
    }
  }
}
