import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Personaje {
  final int id;
  final String nombre;
  final String thumbnailPath;
  final String thumbnailExt;

  Personaje({this.id, this.nombre, this.thumbnailPath, this.thumbnailExt});

  factory Personaje.fromJson(Map<String, dynamic> json) {
    return Personaje(
        id: json['id'] as int,
        nombre: json['name'] as String,
        thumbnailPath: json['thumbnail']['path'] as String,
        thumbnailExt: json['thumbnail']['extension'] as String);
  }
}

//Convierte el body de la respuesta en un List<Personajes>
List<Personaje> parsePersonajes(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Personaje>((json) => Personaje.fromJson(json)).toList();
}

Future<List<Personaje>> fetchPersonajes(http.Client client) async {
  final response = await client.get(
      'https://gateway.marvel.com/v1/public/characters?name=Loki&ts=1&apikey=f2aeb8c5d6295bfdd5627050e1980eaf&hash=e6ff3507113c07c2a3234301b2002277');
  print('fetchPersonajes');
  return parsePersonajes(response.body);
}

class PersonajesList extends StatelessWidget {
  final List<Personaje> personajes;

  PersonajesList({Key key, this.personajes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: personajes.length,
      itemBuilder: (context, index) {
        return Image.network(
            'http://i.annihil.us/u/prod/marvel/i/mg/d/90/526547f509313.jpg');
      },
    );
  }
}
