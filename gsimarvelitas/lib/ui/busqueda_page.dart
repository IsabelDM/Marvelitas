import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:gsimarvelitas/APIRest/personaje.dart';
import 'package:flutter/material.dart';

class BusquedaPage extends StatefulWidget {
  final Future<Personaje> personaje;
  const BusquedaPage({Key key, this.personaje}) : super(key: key);

  @override
  _BusquedaPageState createState() => _BusquedaPageState();
}

class _BusquedaPageState extends State<BusquedaPage> {
  Future<List> personaje = fetchPost();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ProjectList'),
      ),
      body: projectWidget(),
    );
  }

  Widget projectWidget() {
    return FutureBuilder(
      builder: (context, projectSnap) {
        if (projectSnap.connectionState == ConnectionState.none &&
            projectSnap.hasData == null) {
          print('project snapshot data is: ${projectSnap.data}');
          return Container();
        }
        return ListView.builder(
          itemCount: projectSnap.data.length,
          itemBuilder: (context, index) {
            Personaje per = projectSnap.data[index];
            return Card(
             child: Text(per.name),
               
            );
          },
        );
      },
      future: fetchPost(),
    );
  }
}
