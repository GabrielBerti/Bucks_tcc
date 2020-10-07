// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ItemController on _ItemControllerBase, Store {
  final _$idAtom = Atom(name: '_ItemControllerBase.id');

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

  final _$descricaoAtom = Atom(name: '_ItemControllerBase.descricao');

  @override
  TextEditingController get descricao {
    _$descricaoAtom.context.enforceReadPolicy(_$descricaoAtom);
    _$descricaoAtom.reportObserved();
    return super.descricao;
  }

  @override
  set descricao(TextEditingController value) {
    _$descricaoAtom.context.conditionallyRunInAction(() {
      super.descricao = value;
      _$descricaoAtom.reportChanged();
    }, _$descricaoAtom, name: '${_$descricaoAtom.name}_set');
  }

  final _$qtdMinEstoqueAtom = Atom(name: '_ItemControllerBase.qtdMinEstoque');

  @override
  TextEditingController get qtdMinEstoque {
    _$qtdMinEstoqueAtom.context.enforceReadPolicy(_$qtdMinEstoqueAtom);
    _$qtdMinEstoqueAtom.reportObserved();
    return super.qtdMinEstoque;
  }

  @override
  set qtdMinEstoque(TextEditingController value) {
    _$qtdMinEstoqueAtom.context.conditionallyRunInAction(() {
      super.qtdMinEstoque = value;
      _$qtdMinEstoqueAtom.reportChanged();
    }, _$qtdMinEstoqueAtom, name: '${_$qtdMinEstoqueAtom.name}_set');
  }

  final _$cdControlaEstoqueAtom =
      Atom(name: '_ItemControllerBase.cdControlaEstoque');

  @override
  TextEditingController get cdControlaEstoque {
    _$cdControlaEstoqueAtom.context.enforceReadPolicy(_$cdControlaEstoqueAtom);
    _$cdControlaEstoqueAtom.reportObserved();
    return super.cdControlaEstoque;
  }

  @override
  set cdControlaEstoque(TextEditingController value) {
    _$cdControlaEstoqueAtom.context.conditionallyRunInAction(() {
      super.cdControlaEstoque = value;
      _$cdControlaEstoqueAtom.reportChanged();
    }, _$cdControlaEstoqueAtom, name: '${_$cdControlaEstoqueAtom.name}_set');
  }

  final _$fkItemGrupoIdAtom = Atom(name: '_ItemControllerBase.fkItemGrupoId');

  @override
  TextEditingController get fkItemGrupoId {
    _$fkItemGrupoIdAtom.context.enforceReadPolicy(_$fkItemGrupoIdAtom);
    _$fkItemGrupoIdAtom.reportObserved();
    return super.fkItemGrupoId;
  }

  @override
  set fkItemGrupoId(TextEditingController value) {
    _$fkItemGrupoIdAtom.context.conditionallyRunInAction(() {
      super.fkItemGrupoId = value;
      _$fkItemGrupoIdAtom.reportChanged();
    }, _$fkItemGrupoIdAtom, name: '${_$fkItemGrupoIdAtom.name}_set');
  }

  final _$fkItemTipoIdAtom = Atom(name: '_ItemControllerBase.fkItemTipoId');

  @override
  TextEditingController get fkItemTipoId {
    _$fkItemTipoIdAtom.context.enforceReadPolicy(_$fkItemTipoIdAtom);
    _$fkItemTipoIdAtom.reportObserved();
    return super.fkItemTipoId;
  }

  @override
  set fkItemTipoId(TextEditingController value) {
    _$fkItemTipoIdAtom.context.conditionallyRunInAction(() {
      super.fkItemTipoId = value;
      _$fkItemTipoIdAtom.reportChanged();
    }, _$fkItemTipoIdAtom, name: '${_$fkItemTipoIdAtom.name}_set');
  }

  final _$fkItemUnmedIdAtom = Atom(name: '_ItemControllerBase.fkItemUnmedId');

  @override
  TextEditingController get fkItemUnmedId {
    _$fkItemUnmedIdAtom.context.enforceReadPolicy(_$fkItemUnmedIdAtom);
    _$fkItemUnmedIdAtom.reportObserved();
    return super.fkItemUnmedId;
  }

  @override
  set fkItemUnmedId(TextEditingController value) {
    _$fkItemUnmedIdAtom.context.conditionallyRunInAction(() {
      super.fkItemUnmedId = value;
      _$fkItemUnmedIdAtom.reportChanged();
    }, _$fkItemUnmedIdAtom, name: '${_$fkItemUnmedIdAtom.name}_set');
  }

  final _$valueAtom = Atom(name: '_ItemControllerBase.value');

  @override
  int get value {
    _$valueAtom.context.enforceReadPolicy(_$valueAtom);
    _$valueAtom.reportObserved();
    return super.value;
  }

  @override
  set value(int value) {
    _$valueAtom.context.conditionallyRunInAction(() {
      super.value = value;
      _$valueAtom.reportChanged();
    }, _$valueAtom, name: '${_$valueAtom.name}_set');
  }

  final _$salvarItemAsyncAction = AsyncAction('salvarItem');

  @override
  Future salvarItem(
      {@required ItemController store,
      @required ItemListController storeItemList}) {
    return _$salvarItemAsyncAction.run(
        () => super.salvarItem(store: store, storeItemList: storeItemList));
  }

  final _$_ItemControllerBaseActionController =
      ActionController(name: '_ItemControllerBase');

  @override
  dynamic deletarItem({Item item}) {
    final _$actionInfo = _$_ItemControllerBaseActionController.startAction();
    try {
      return super.deletarItem(item: item);
    } finally {
      _$_ItemControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void increment() {
    final _$actionInfo = _$_ItemControllerBaseActionController.startAction();
    try {
      return super.increment();
    } finally {
      _$_ItemControllerBaseActionController.endAction(_$actionInfo);
    }
  }
}
