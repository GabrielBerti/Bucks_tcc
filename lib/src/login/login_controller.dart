import 'package:mobx/mobx.dart';

part 'login_controller.g.dart';

class LoginController = _LoginBase with _$LoginController;

abstract class _LoginBase with Store {
  @observable
  bool progress = false;

  @action
  void enabledProgress() {
    progress = true;
  }

  @action
  void disableProgress() {
    progress = false;
  }
}
