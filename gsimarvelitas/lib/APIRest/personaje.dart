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

List<Serie> procesarSerie(List series) {
  List<Serie> colecSerie=[];
  for (var ser in series) {
    var coleccion = Serie(resourceURI: ser["resourceURI"], name: ser["name"]);
    colecSerie.add(coleccion);
  }
  return colecSerie;
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
      series: procesarSerie(res['series']['items']),
    );
    returnlist.add(person);
  }

  return returnlist;
}

class Personaje {
  String name;
  String thumbnailpath;
  String thumbnailext;
  List<Serie> series;

  Personaje({
    this.name,
    this.thumbnailpath,
    this.thumbnailext,
    this.series,
  });
}

class Serie {
  String resourceURI;
  String name;

  Serie({this.resourceURI, this.name});
}
