import 'package:dio/dio.dart';

class DioSingleton {
  static final DioSingleton _instance = DioSingleton.getInstance();

  factory DioSingleton() => _instance;

  DioSingleton.getInstance();

  static Dio _dioInstance;

  Dio get req {
    if (_dioInstance != null) return _dioInstance;

    _dioInstance = Dio(_options());
    return _dioInstance;
  }

  _options() => BaseOptions(
        connectTimeout: 30000,
        // receiveTimeout: 3000,
      );
}
