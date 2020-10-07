import 'dart:async';
import 'package:flutter/services.dart';
import 'package:barcode_scan/barcode_scan.dart';

class Barcode {
  String barcode;
  Future<String> scan() async {
    try {
      this.barcode = await BarcodeScanner.scan();
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        this.barcode = 'O usuário não concedeu a permissão da câmera!';
      } else {
        this.barcode = 'Erro desconhecido: $e';
      }
    } on FormatException {
      this.barcode =
          'null (O usuário retornou usando o botão "voltar" antes de digitalizar qualquer coisa. Resultado)';
    } catch (e) {
      this.barcode = 'Erro desconhecido: $e';
    }
    return this.barcode;
  }
}
