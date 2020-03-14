import 'dart:async';
import 'package:http/http.dart' as http;

const baseUrl =
    "https://gateway.marvel.com/v1/public/characters?name=Loki&ts=1&apikey=f2aeb8c5d6295bfdd5627050e1980eaf&hash=e6ff3507113c07c2a3234301b2002277";

class API {
  static Future getPersonajes() {
    var url = baseUrl;
    return http.get(url);
  }
}


