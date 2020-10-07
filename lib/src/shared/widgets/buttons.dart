import 'package:bucks/src/shared/widgets/snackbar_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'button.dart';

class Buttons extends StatefulWidget {
  final dynamic store;

  const Buttons({Key key, @required this.store}) : super(key: key);

  @override
  _Buttons createState() => _Buttons();
}

class _Buttons extends State<Buttons> {
  dynamic get store => widget.store;

  get onPressed => null;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        // Expanded(
        //   flex: 6,
        //   child: Container(
        //     //children: <Widget>[
        //     alignment: Alignment.center,
        //     child: AppButton(
        //       "CANCELAR",
        //       onPressed,
        //       color1: Colors.blue,
        //       color2: Colors.blueAccent,
        //     ),
        //     //],
        //   ),
        // ),
        Expanded(
          flex: 6,
          child: Container(
            //children: <Widget>[
            alignment: Alignment.center,
            child: AppButton(
              "SALVAR",
              onPressedButtons,
              color1: Colors.blue,
              color2: Colors.blueAccent,
            ),
            //],
          ),
        ),
      ],
    );
  }

  void onPressedButtons() async {
    var response = await store.validateAlmoxarifado();

    if (response.isEmpty) {
      snackbarError(context: context, msg: response);
    } else {
      snackbarError(context: context, msg: response);
    }
  }
}

//------------------------------------------------------------------------

class ButtonsConfiguracao extends StatefulWidget {
  final dynamic store;

  const ButtonsConfiguracao({Key key, @required this.store}) : super(key: key);

  @override
  _ButtonsConfiguracao createState() => _ButtonsConfiguracao();
}

class _ButtonsConfiguracao extends State<ButtonsConfiguracao> {
  dynamic get store => widget.store;

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (BuildContext context) {
      if (!store.hasResultsTextString) {
        //if (1 == 2) {
        return Container();
      }

      return Row(
        children: <Widget>[
          Expanded(
            flex: 6,
            child: Container(
              //children: <Widget>[
              alignment: Alignment.center,
              child: AppButton(
                store.textButton,
                onPressedButtonsConfiguracao,
                color1: Colors.blue,
                color2: Colors.blueAccent,
              ),
              //],
            ),
          ),
        ],
      );
    });
  }

  void onPressedButtonsConfiguracao() async {
    var response = await store.validateButton();

    if (store.textButton == "Sincronizar Dados") {
      if (response.isEmpty) {
        await store.deleteDados();
        await store.fetchAlmoxarifado();
        // await store.fetchReceituario();
        await store.fetchReceituarioItem();
        await store.saveUnidadeOff();
        await store.saveAlmoxarifadoOff();
        // await store.saveReceituarioOff();
        await store.saveReceituarioItemOff();
      } else {
        snackbarError(context: context, msg: response);
      }
    } else {
      //realizar a transferencia, recebimento, consumo
      await store.deleteDados();
      store.buttonText();
    }
  }
}
