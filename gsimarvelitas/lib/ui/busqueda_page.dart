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
  final myController = TextEditingController();
  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: projectWidget(),
    );
  }

  @override
  void initState() {
    super.initState();

    myController.addListener(_printLatestValue);
  }

  _printLatestValue() {
    print(myController.text);
    fetchPost(myController.text);
    initState();
  }

  Widget projectWidget() {
    return FutureBuilder(
      builder: (context, projectSnap) {
        if (projectSnap.connectionState == ConnectionState.none &&
            projectSnap.hasData == null) {
          print('project snapshot data is: ${projectSnap.data}');
          return Container();
        }
        return Scaffold(
          backgroundColor: Colors.red,
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
                    child: ListView.builder(
                      itemCount: projectSnap.data.length,
                      itemBuilder: (context, index) {
                        Personaje per = projectSnap.data[index];
                        return Card(
                          child: new InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, "/resultados");
                            },
                            child: new Container(
                              constraints: new BoxConstraints.expand(
                                height: 200.0,
                              ),
                              alignment: Alignment.topLeft,
                              padding:
                                  new EdgeInsets.only(left: 16.0, bottom: 8.0),
                              decoration: new BoxDecoration(
                                image: new DecorationImage(
                                  image: new NetworkImage(
                                    per.thumbnailpath + "." + per.thumbnailext,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: new Text(
                                per.name,
                                style: new TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  backgroundColor:
                                      new Color.fromRGBO(0, 0, 0, 75),
                                  fontSize: 40.0,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.menu,
                              color: Colors.white,
                            ),
                          ),
                          Image(
                            image: AssetImage('assets/login_logo.png'),
                            height: 350,
                            width: 100,
                          ),
                          
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.filter_list,
                              color: Colors.white,
                            ),
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
                              // controller: TextEditingController(text: locations[0]),
                              cursorColor: Theme.of(context).primaryColor,
                              decoration: InputDecoration(
                                  hintText: "Buscar personaje...",
                                  hintStyle: TextStyle(
                                      color: Colors.black38, fontSize: 16),
                                  prefixIcon: Material(
                                    elevation: 0.0,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                    child: Icon(Icons.search),
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 13)),
                              controller: myController,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      future: fetchPost(myController.text),
    );
  }
}
