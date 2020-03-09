import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

//https://gateway.marvel.com/v1/public/characters?name=Loki&ts=1&apikey=f2aeb8c5d6295bfdd5627050e1980eaf&hash=e6ff3507113c07c2a3234301b2002277

Future<Post> fetchPost() async {
  final response = await http.get(
      'https://gateway.marvel.com/v1/public/characters?name=Loki&ts=1&apikey=f2aeb8c5d6295bfdd5627050e1980eaf&hash=e6ff3507113c07c2a3234301b2002277');
  if (response.statusCode == 200) {
    print('status 200');
    return Post.fromJson(json.decode(response.body));
  } else {
    print('Error al cargar');
    throw Exception('Error al cargar la petición');
  }
}

class Post {
  final String nombre;
  final String pathFoto;
  final String formatoFoto;
  final String series;

  Post({this.nombre, this.pathFoto, this.formatoFoto, this.series});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        nombre: json['name'],
        pathFoto: json['thumbnail']['path'],
        formatoFoto: json['thumbnail']['extension'],
        series: json['series']);
  }
}
