

import 'package:bucks/src/shared/utils/prefs.dart';

class CoreService {
  // static final String urlBaseMoedas =
  //     "http://portal.cutrale.int/MercadoIndiceMoedasWS/v1";
  static final String urlBaseMoedas =
      "http://172.16.0.144/MercadoIndiceMoedasWS/v1";

  static final String urlBaseVeiculos =
         "http://172.16.3.48:7000/SupFrutaWS/rest/mobile"; 
    //  "http://portal.cutrale.int/SupFrutaWS/rest/mobile";

  static final String urlBaseCenso = 
   "http://172.16.3.48:7000/SupFrutaWS/rest/supFrutaCenso";
   //   "http://portal.cutrale.int/SupFrutaWS/rest/supFrutaCenso";

  static Future<String> getUser() async {
    var user = await Prefs.getString("user");
    return user.toUpperCase();
  }

  static Future<String> getPassword() async {
    var password = await Prefs.getString("senha");
    return password;
  }

}
