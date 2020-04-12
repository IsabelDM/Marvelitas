
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List> fetchPost(String busqueda) async {
  String urlBasic =
      "https://gateway.marvel.com/v1/public/characters?nameStartsWith=";
  String key =
      "&ts=1&apikey=f2aeb8c5d6295bfdd5627050e1980eaf&hash=e6ff3507113c07c2a3234301b2002277";

  final response = await http.get(urlBasic + busqueda + key);
  print(urlBasic + busqueda + key);
  if (response.statusCode == 200) {
    return fromJson(json.decode(response.body));
  } else {
    return null;
  }
}

Future<List> fetchSerie(int idPersonaje) async {
  String urlBasic = 'https://gateway.marvel.com:443/v1/public/characters/';
  String key =
      "/series?&ts=1&apikey=f2aeb8c5d6295bfdd5627050e1980eaf&hash=e6ff3507113c07c2a3234301b2002277";
  print(urlBasic + idPersonaje.toString() + key);
  final response = await http.get(urlBasic + idPersonaje.toString() + key);
  if (response.statusCode == 200) {
    return fromSeries(json.decode(response.body));
  } else {
    return null;
  }
}

/*List<Serie> procesarSerie(List series) {
  List<Serie> colecSerie = [];
  for (var ser in series) {
    var coleccion = Serie(resourceURI: ser["resourceURI"], name: ser["name"]);
    colecSerie.add(coleccion);
  }
  return colecSerie;
}
*/
Future<List> fromJson(Map<String, dynamic> json) async {
  Iterable resultados = json['data']['results'];
  var resulist = resultados.toList();
  var returnlist = [];

  for (var res in resulist) {
    var person = Personaje(
      id: res['id'],
      name: res['name'],
      thumbnailpath: res['thumbnail']['path'],
      thumbnailext: res['thumbnail']['extension'],
      //series: procesarSerie(res['series']['items']),
    );
    returnlist.add(person);
  }

  return returnlist;
}

Future<List> fromSeries(Map<String, dynamic> json) async {
  Iterable resultados = json['data']['results'];
  var resultlist = resultados.toList();
  var returnlist = [];

  for (var res in resultlist) {
    var series = Serie(
      title: res['title'],
      thumbnail: res['thumbnail']['path'],
      thumnailext: res['thumbnail']['extension'],
    );

    returnlist.add(series);
  }
  return returnlist;
}

class Personaje {
  int id;
  String name;
  String thumbnailpath;
  String thumbnailext;
  List<Serie> series;

  Personaje({
    this.id,
    this.name,
    this.thumbnailpath,
    this.thumbnailext,
    this.series,
  });
}

class Serie {
  String title;
  String thumbnail;
  String thumnailext;

  Serie({this.title, this.thumbnail, this.thumnailext});
}
