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
          title: Text('Buscador'),
        ),
        body: createListView());
  }

  Widget createListView() {
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
            return Column(
              children: <Widget>[
                SizedBox(
                  child: CircularProgressIndicator(),
                  width: 60,
                  height: 60,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text('Esperando resultados...'),
                )
              ],
            );
          },
        );
      },
      future: fetchPost(),
    );
    /*return Scaffold(
      appBar: AppBar(
        title: Text("Lista personajes"),
      ),
      body: Center(
        child: FutureBuilder<List>(
          future: personaje,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return new Row(children: snapshot)
             // return Text(snapshot.data[19].name);
            } else if (snapshot.hasError) {
              return Text("$snapshot.error");
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
*/
  }
}
