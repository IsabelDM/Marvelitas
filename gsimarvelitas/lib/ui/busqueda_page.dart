import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:getflutter/components/shimmer/gf_shimmer.dart';
import 'package:gsimarvelitas/APIRest/personaje.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gsimarvelitas/MenuHamburguesa/navigationBloc.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class BusquedaPage extends StatefulWidget with NavigationStates {
  final Future<Personaje> personaje;
  const BusquedaPage({
    Key key,
    this.personaje,
  }) : super(key: key);

  @override
  _BusquedaPageState createState() => _BusquedaPageState();
}

class _BusquedaPageState extends State<BusquedaPage> {
  List<String> lines;
  final _myController = TextEditingController();

  @override
  void dispose() {
    _myController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _write("");
    _myController.addListener(_printLatestValue);
  }

  _printLatestValue() {
    fetchPost(_myController.text);
    setState(() {});
    print("busqueda_page: " + _myController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/background.jpg"), fit: BoxFit.cover)),
        child: Container(
          child: projectWidget(),
        ),
      ),
    );
  }

  Widget busca() {
    return Stack(
      children: <Widget>[
        Container(
          height: 140,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(
                  image: AssetImage('assets/login_logo.png'),
                  height: 350,
                  width: 100,
                ),
              ],
            ),
          ),
        ),
        Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 110,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  child: TextField(
                    cursorColor: Theme.of(context).primaryColor,
                    decoration: InputDecoration(
                        hintText: "Buscar personaje...",
                        hintStyle:
                            TextStyle(color: Colors.black38, fontSize: 16),
                        prefixIcon: Material(
                          elevation: 0.0,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          child: Icon(Icons.search),
                        ),
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
                    controller: _myController,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget listaPersonajes(context, projectSnap) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 145),
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: GridView.builder(
                  itemCount: projectSnap.data.length,
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    Personaje per = projectSnap.data[index];
                    return Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        side: BorderSide(color: Colors.white),
                      ),
                      child: new InkWell(
                        onTap: () {
                          _write(per.name);
                          Navigator.pushNamed(context, '/resultados',
                              arguments: per);
                          /*  BlocProvider.of<NavigationBloc>(context)
                        .add(NavigationEvents.ResultadosClickedEvent, arguments: per);*/
                        },
                        child: new Container(
                          constraints: new BoxConstraints.expand(
                            height: 200.0,
                          ),
                          alignment: Alignment.center,
                          padding: new EdgeInsets.only(left: 16.0, bottom: 8.0),
                          decoration: new BoxDecoration(
                            borderRadius:
                                new BorderRadius.all(Radius.circular(10)),
                            image: new DecorationImage(
                              image: new NetworkImage(
                                per.thumbnailpath + "." + per.thumbnailext,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: new Text(per.name,
                              style: GoogleFonts.specialElite(
                                color: Colors.white,
                                backgroundColor:
                                    new Color.fromRGBO(0, 0, 0, 75),
                                fontSize: 25.0,
                              )),
                        ),
                      ),
                    );
                  },
                ),
              ),
              busca(),
            ],
          ),
        ),
      ),
    );
  }

  Widget projectWidget() {
    return FutureBuilder(
      future: fetchPost(_myController.text),
      builder: (context, projectSnap) {
        if (projectSnap.hasError) {
          return Text('Error: ${projectSnap.error}');
        } else if (!projectSnap.hasData) {
          return mostrarHistorial();
        }
        return listaPersonajes(context, projectSnap);
      },
    );
  }

  Widget historial(context, lines) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
            child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: <Widget>[
              /*Text(
            "Historial",
            textAlign: TextAlign.center,
            style: GoogleFonts.amarante(
                color: Colors.red,
                fontSize: 50.0,
                backgroundColor: Colors.black),
          ),*/
              Container(
                padding: EdgeInsets.only(top: 15),
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: ListView.builder(
                    itemCount: lines.data.length,
                    itemBuilder: (context, index) {
                      String historial = lines.data[index];
                      return Container(
                        height: 50.0,
                        child: Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            side: BorderSide(color: Colors.black38),
                          ),
                          child: new InkWell(
                            onTap: () {
                              //_printLatestValue();
                            },
                            child: Container(
                              child: Center(
                                child: Text(
                                  historial.toString(),
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.specialElite(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              busca()
            ],
          ),
        )));
  }

  //HISTORIAL
  _write(String text) async {
    final filename = 'historial.txt';
    String dir = (await getApplicationDocumentsDirectory()).path;
    final File file = File('$dir/$filename');
    await file.writeAsString(text + "\n", mode: FileMode.append, flush: false);
    print("Archivo: $file");
  }

  Future<List<String>> _read() async {
    try {
      final filename = 'historial.txt';
      String dir = (await getApplicationDocumentsDirectory()).path;
      final File file = File('$dir/$filename');
      lines = file.readAsLinesSync();
      print(lines);
      historial(context, lines);
    } catch (e) {
      print(e.toString());
    }
    return lines;
  }

  mostrarHistorial() {
    return FutureBuilder<List<String>>(
        future: _read(),
        builder: (context, lines) {
          if (lines.hasData) {
            return historial(context, lines);
          } else {
            return (Image.asset('assets/loading.gif'));
          }
        });
  }
}
