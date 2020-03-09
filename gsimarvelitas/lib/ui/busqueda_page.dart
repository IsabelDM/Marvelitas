import "package:flutter/material.dart";
import 'dart:async';
import 'package:gsimarvelitas/API%20Rest/Personajes.dart';
import 'package:gsimarvelitas/API%20Rest/TodoApiClient.dart';
import 'package:http/http.dart' as http;

class BusquedaPage extends StatefulWidget {
  @override
  _BusquedaPageState createState() => _BusquedaPageState();
}

class _BusquedaPageState extends State<BusquedaPage> {
  Future<Post> post;
  @override
  void initState() {
    super.initState();
    post = fetchPost();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<List<Personaje>>(
        future: fetchPersonajes(http.Client()),
        builder: (context, snapshot) {
          print('busqueda build');
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? PersonajesList(personajes: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

