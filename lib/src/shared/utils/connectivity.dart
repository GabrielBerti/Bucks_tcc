import 'package:connectivity/connectivity.dart';

Future<ConnectivityResult> checkConnection() async {
  var con = await Connectivity().checkConnectivity();
  return con;
}
