import 'dart:io';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:bucks/src/classes/login_model.dart';
import 'package:bucks/src/shared/services/core_service.dart';
import 'package:bucks/src/shared/utils/finger_print.dart';
import 'package:bucks/src/shared/utils/response.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'dart:convert' as convert;

class LoginRepository extends Disposable {

  static Future<GenericResponse<LoginResponse>> loginOffiline(
      String usernameForm, String passwordForm) async {
    final username = await CoreService.getUser();
    final pass = await CoreService.getPassword();

    if (username == "") {
      return GenericResponse(false,
          msg: "Favor conectar na internet para fazer o primeiro login",
          result: null);
    }

    if (username == usernameForm.toUpperCase() && passwordForm == pass) {
      return GenericResponse(true,
          msg: "Login realizado com sucesso", result: null);
    } else {
      return GenericResponse(false,
          msg: "login/senha inválidas.", result: null);
    }
  }

  static Future<GenericResponse<LoginResponse>> loginByPass(
      String usernameForm, String passwordForm) async {
    final dio = Dio();
    String username = 'CutraleAppUser';
    String password = 'Suco1000';
    try {
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
      final urlLogin =
          'https://brlnwl.cutrale.com/webserviceApps/controlId/portalServicesWS/loginBody';

      print("post urlLogin > $urlLogin");

      String basicAuth = 'Basic ' +
          convert.base64Encode(convert.utf8.encode('$username:$password'));

      var response = await dio.post(
        urlLogin,
        data: {
          "username": usernameForm.toUpperCase(),
          "password": passwordForm,
          "macAddress": 00.00
        },
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            HttpHeaders.authorizationHeader: basicAuth,
          },
        ),
      );

      return GenericResponse(true,
          msg: "Login realizado com sucesso", result: null);
    } catch (error, stacktrace) {
      print("Login error: $error - $stacktrace");
      return GenericResponse(false, msg: "login/senha inválidas.");
    }
  }

  static Future<bool> checkExistFingerprint() async {
    final userBUCKS = await CoreService.getUser();

    try {
      if (userBUCKS != "") {
        return await FingerPrint.canCheckBiometrics();
      }
    } catch (error, stacktrace) {
      print("Fingerprint error: $error - $stacktrace");
    }

    return false;
  }

  @override
  void dispose() {}
}
