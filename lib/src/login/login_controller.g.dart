// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginController on _LoginBase, Store {
  final _$progressAtom = Atom(name: '_LoginBase.progress');

  @override
  bool get progress {
    _$progressAtom.context.enforceReadPolicy(_$progressAtom);
    _$progressAtom.reportObserved();
    return super.progress;
  }

  @override
  set progress(bool value) {
    _$progressAtom.context.conditionallyRunInAction(() {
      super.progress = value;
      _$progressAtom.reportChanged();
    }, _$progressAtom, name: '${_$progressAtom.name}_set');
  }

  final _$_LoginBaseActionController = ActionController(name: '_LoginBase');

  @override
  void enabledProgress() {
    final _$actionInfo = _$_LoginBaseActionController.startAction();
    try {
      return super.enabledProgress();
    } finally {
      _$_LoginBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void disableProgress() {
    final _$actionInfo = _$_LoginBaseActionController.startAction();
    try {
      return super.disableProgress();
    } finally {
      _$_LoginBaseActionController.endAction(_$actionInfo);
    }
  }
}
