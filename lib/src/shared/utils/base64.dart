import 'dart:convert';

import 'dart:typed_data';

class Base64Converter{

  static Uint8List convertBase64ToArrayBytes({String stringBase64}){
     var _base64 = Base64Decoder();
     return _base64.convert(stringBase64);
  } 
   
}