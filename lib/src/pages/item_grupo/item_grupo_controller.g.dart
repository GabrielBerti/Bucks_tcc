// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_grupo_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ItemGrupoController on _ItemGrupoControllerBase, Store {
  final _$idAtom = Atom(name: '_ItemGrupoControllerBase.id');

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

  final _$descrAtom = Atom(name: '_ItemGrupoControllerBase.descr');

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

  final _$valueAtom = Atom(name: '_ItemGrupoControllerBase.value');

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

  final _$salvarAsyncAction = AsyncAction('salvar');

  @override
  Future salvar(
      {@required ItemGrupoController store,
      @required ItemGrupoListController storeItemGrupoList}) {
    return _$salvarAsyncAction.run(() =>
        super.salvar(store: store, storeItemGrupoList: storeItemGrupoList));
  }

  final _$_ItemGrupoControllerBaseActionController =
      ActionController(name: '_ItemGrupoControllerBase');

  @override
  dynamic deletarItemGrupo({ItemGrupo itemGrupo}) {
    final _$actionInfo =
        _$_ItemGrupoControllerBaseActionController.startAction();
    try {
      return super.deletarItemGrupo(itemGrupo: itemGrupo);
    } finally {
      _$_ItemGrupoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void increment() {
    final _$actionInfo =
        _$_ItemGrupoControllerBaseActionController.startAction();
    try {
      return super.increment();
    } finally {
      _$_ItemGrupoControllerBaseActionController.endAction(_$actionInfo);
    }
  }
}
