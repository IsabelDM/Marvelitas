import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gsimarvelitas/APIRest/personaje.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:gsimarvelitas/APIRest/personaje.dart';

//import 'package:flutter/rendering.dart';

class Resultados extends StatefulWidget {
  final Future<Serie> series;
  final Future<Personaje> personaje; 
  const Resultados({Key key, this.series, this.personaje, }) : super(key: key);
  @override
  _ResultadosState createState() => _ResultadosState();
}

class _ResultadosState extends State<Resultados> with SingleTickerProviderStateMixin {
  bool isCollapsed = true;
  double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 500);
  AnimationController _controller;

  AppBar appBar = AppBar();
  double borderRadius = 0.0;

  int _navBarIndex = 0;
  TabController tabController;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
  }

  @override
  void dispose() {
    _controller.dispose();
    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(() {
      setState(() {
        _navBarIndex = tabController.index;
      });
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return WillPopScope(
      onWillPop: () async {
        if (!isCollapsed) {
          setState(() {
            _controller.reverse();
            borderRadius = 0.0;
            isCollapsed = !isCollapsed;
          });
          return false;
        } else
          return true;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Stack(
          children: <Widget>[
            menu(context),
            AnimatedPositioned(
                left: isCollapsed ? 0 : 0.6 * screenWidth,
                right: isCollapsed ? 0 : -0.2 * screenWidth,
                top: isCollapsed ? 0 : screenHeight * 0.1,
                bottom: isCollapsed ? 0 : screenHeight * 0.1,
                duration: duration,
                curve: Curves.fastOutSlowIn,
                child: dashboard(context, widget.series)),
          ],
        ),
      ),
    );
  }

  Widget menu(context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 32.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: FractionallySizedBox(
            widthFactor: 0.6,
            heightFactor: 0.8,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName: Text("Leonardo DiCaprio"),
                  accountEmail: Text("bestperritoever@guau.com"),
                  currentAccountPicture: Image.asset('assets/dicaprio.jpg'),
                  decoration: BoxDecoration(
                    color: Colors.red,
                  ),
                ),
                ListTile(
                  title: Text('Perfil'),
                  leading: Icon(Icons.person),
                  onTap: () {
                    Navigator.pushNamed(context, "/perfil");
                  },
                ),
                ListTile(
                  title: Text('Ajustes'),
                  leading: Icon(Icons.settings),
                ),
                ListTile(
                  title: Text('Cambio de Búsqueda'),
                  leading: Icon(Icons.search),
                  onTap: () {
                    Navigator.pushNamed(context, "/busqueda");
                  },
                ),
                ListTile(
                  title: Text('Log Out'),
                  leading: Icon(Icons.exit_to_app),
                  onTap: () {
                    Navigator.pushNamed(context, "/");
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
    // ),
    // )
  }

  Widget dashboard(context, personaje) {
    return SafeArea(
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        type: MaterialType.card,
        animationDuration: duration,
        color: Theme.of(context).scaffoldBackgroundColor,
        elevation: 8,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              centerTitle: true,
              title:
                  Image.asset('assets/login_logo.png', height: 350, width: 100),
              //, alignment: Alignment.center,
              leading: IconButton(
                  icon: AnimatedIcon(
                    icon: AnimatedIcons.menu_close,
                    progress: _controller,
                  ),
                  onPressed: () {
                    setState(() {
                      if (isCollapsed) {
                        _controller.forward();

                        borderRadius = 16.0;
                      } else {
                        _controller.reverse();

                        borderRadius = 0.0;
                      }

                      isCollapsed = !isCollapsed;
                    });
                  }),
            ),
           body:SingleChildScrollView(
             scrollDirection: Axis.vertical,
             physics: ClampingScrollPhysics(),
             child:Container(
               child : Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: <Widget>[
                   SizedBox(height: 50),
                   Container(
                     height: 200,
                     child: PageView(
                       controller: PageController(viewportFraction: 0.8),
                       scrollDirection: Axis.horizontal,
                       pageSnapping: true,
                     //  children: projectWidget()
                     )
                   )
                 ]
               )
             ))
            ),
          ),
        ),
      //),
    );
  }
  Widget listaComics(context,projectSnap){
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
                    Serie ser = projectSnap.data[index];
                    Personaje per = projectSnap.data[index];
                    return Card( 
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
 /*  Widget projectWidget() {
    
    return FutureBuilder(
     
      future: fetchSerie(per.id),
      builder: (context, projectSnap) {
        if (projectSnap.hasError) {
          return Text('Error: ${projectSnap.error}');
        } else if (!projectSnap.hasData) {
         return 
        }
        return listaComics(context, projectSnap);
      },
    );
  }*/
}