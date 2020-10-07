import 'package:dio/dio.dart';

String dioHandleException(error, String texto) {
    String descricaoError = "";
    if (error is DioError) {
      switch (error.type) {
        case DioErrorType.RESPONSE:
          if (error.response.statusCode == 400) {
            descricaoError = error.response.data;
          } else {
            descricaoError =
                "$texto - ${error.response.statusMessage}";
          }
          break;
        case DioErrorType.CONNECT_TIMEOUT:
          descricaoError =
              "$texto - ${error.response.statusMessage}";
          break;
        case DioErrorType.SEND_TIMEOUT:
          descricaoError =
              "$texto - ${error.response.statusMessage}";
          break;
        case DioErrorType.RECEIVE_TIMEOUT:
          descricaoError =
              "$texto - ${error.response.statusMessage}";
          break;
        case DioErrorType.CANCEL:
          descricaoError =
              "$texto - ${error.response.statusMessage}";
          break;
        case DioErrorType.DEFAULT:
          descricaoError =
              "$texto - ${error.response.statusMessage}";
          break;
      }
    }
    return descricaoError;
  }