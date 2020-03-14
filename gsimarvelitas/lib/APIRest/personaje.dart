import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List> fetchPost(String busqueda) async {
  String urlBasic =
      "https://gateway.marvel.com/v1/public/characters?nameStartsWith=";
  String key =
      "&ts=1&apikey=f2aeb8c5d6295bfdd5627050e1980eaf&hash=e6ff3507113c07c2a3234301b2002277";
  if (busqueda == "" || busqueda == null) {
    busqueda = "A";
  }
    final response = await http.get(urlBasic + busqueda + key);
    if (response.statusCode == 200) {
      return fromJson(json.decode(response.body));
    } else {
      throw Exception('Fallo al cargar la petición a la API');
    }
  }

Future<List> fromJson(Map<String, dynamic> json) async {
  Iterable resultados = json['data']['results'];
  var resulist = resultados.toList();
  var returnlist = [];

  for (var res in resulist) {
    var person = Personaje(
      name: res['name'],
      thumbnailpath: res['thumbnail']['path'],
      thumbnailext: res['thumbnail']['extension'],
      //series: json['data']['results'][0]['series']
    );
    returnlist.add(person);
  }

  return returnlist;
}

class Personaje {
  String name;
  String thumbnailpath;
  String thumbnailext;
  //String series;

  Personaje({
    this.name,
    this.thumbnailpath,
    this.thumbnailext,
    //this.series,
  });
}
