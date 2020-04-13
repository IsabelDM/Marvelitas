import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gsimarvelitas/APIRest/personaje.dart';
import 'dart:async';
import 'package:gsimarvelitas/MenuHamburguesa/navigationBloc.dart';

//import 'package:flutter/rendering.dart';

class Resultados extends StatefulWidget with NavigationStates{
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
           // menu(context),
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
            appBar: MyCustomAppBar(
              height: 150,
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
  class MyCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  
/*
TODO ESTO QUE VIENE AQUÍ ES PARA PODER MODIFICAR EL TAMAÑO DE LA APPBAR, MADRE SANTA 
*/
  const MyCustomAppBar({
    Key key,
    @required this.height,
  }) : super(key: key);

   @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
      return Column(
      children: [
        Container(
          color: Colors.black,
          child: Padding(
            padding: EdgeInsets.all(1),
            child: Container(
              color: Colors.black,
              padding: EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Image(
                  image: AssetImage('assets/login_logo.png'),
                  height: 100,
                  width: 100,

                ),
              ]),
            ),
          ),
        ),
      ],
    );
  }
  }
