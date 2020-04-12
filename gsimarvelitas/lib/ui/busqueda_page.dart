import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsimarvelitas/APIRest/personaje.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gsimarvelitas/MenuHamburguesa/navigationBloc.dart';

class BusquedaPage extends StatefulWidget with NavigationStates {
  final Future<Personaje> personaje;
  final Function onMenuTap;
  const BusquedaPage({Key key, this.personaje, this.onMenuTap})
      : super(key: key);

  @override
  _BusquedaPageState createState() => _BusquedaPageState();
}

class _BusquedaPageState extends State<BusquedaPage> {
  final myController = TextEditingController();
  @override
  void dispose() {
    myController.dispose();
    super.dispose();
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

  @override
  void initState() {
    super.initState();
    myController.addListener(_printLatestValue);
  }

  _printLatestValue() {
    fetchPost(myController.text);
    setState(() {});
    print("busqueda_page: " + myController.text);
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
                    controller: myController,
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
                           BlocProvider.of<NavigationBloc>(context)
                        .add(NavigationEvents.ResultadosClickedEvent);
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
      future: fetchPost(myController.text),
      builder: (context, projectSnap) {
        if (projectSnap.hasError) {
          return Text('Error: ${projectSnap.error}');
        } else if (!projectSnap.hasData) {
          return busca();
        }
        return listaPersonajes(context, projectSnap);
      },
    );
  }
}
