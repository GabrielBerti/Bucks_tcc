import 'package:bucks/src/login/login_controller.dart';
import 'package:bucks/src/pages/dash_board.dart';
import 'package:bucks/src/shared/database/users_db.dart';
import 'package:bucks/src/shared/utils/nav.dart';
import 'package:bucks/src/shared/widgets/flat_button_app.dart';
import 'package:bucks/src/shared/widgets/text_field_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _tLogin = TextEditingController();
  final _tSenha = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  LoginController controller = LoginController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: Padding(
        padding: EdgeInsets.all(16),
        child: _body(context),
      ),
    );
  }

  String _validateLogin(String text) {
    if (text.isEmpty) {
      return "Informe o login";
    }

    if (text != "ADMIN" && text != "admin") {
      return "Usuário inválido";
    }
    return null;
  }

  String _validateSenha(String text) {
    if (text.isEmpty) {
      return "Informe a senha";
    }

    if ((text != "ADMIN" && text != "admin") ||
        (_tLogin.text != 'ADMIN' && _tLogin.text != 'admin')) {
      return "Senha inválida";
    }
    return null;
  }

  _body(context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          // _image(),
          _campos(),
        ],
      ),
    );
  }

  // _image() {
  //   return Container(
  //     height: 200,
  //     padding: EdgeInsets.only(top: 10),
  //     child: Image.asset(
  //       "images/heart.png",
  //       height: 100,
  //     ),
  //   );
  // }

  _campos() {
    return Card(
      elevation: 10,
      child: Container(
        padding: EdgeInsets.only(left: 8, right: 8, bottom: 16),
        child: Column(
          children: <Widget>[
            TextFieldApp(
              controller: _tLogin,
              icone: Icon(Icons.person),
              text: "Digite o seu Login",
              validator: _validateLogin,
            ),
            TextFieldApp(
              controller: _tSenha,
              icone: Icon(Icons.lock_outline),
              text: "Digite sua Senha",
              validator: _validateSenha,
              password: true,
            ),
            _button(),
          ],
        ),
      ),
    );
  }

  _button() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
      ),
      margin: EdgeInsets.only(top: 20),
      child: Observer(
        builder: (_) => controller.progress
            ? LinearProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.blueAccent),
              )
            : Container(
                width: 550,
                child: FlatButtonApp(
                  label: "Login",
                  onPressed: () => _onClickLogin(context),
                ),
              ),
      ),
    );
  }

  void _onClickLogin(BuildContext context) async {
    final login = _tLogin.text;
    final senha = _tSenha.text;

    print("Login: $login, Senha: $senha");

    if (!_formKey.currentState.validate()) {
      return;
    }

    final db = UserDb.getInstance();
    db.db;

    controller.enabledProgress();

    pushReplacement(context, DashboardMateriaisModule());

    controller.disableProgress();
  }
}
