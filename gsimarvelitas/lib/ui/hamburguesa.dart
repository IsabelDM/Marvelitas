

import 'package:flutter/material.dart';

class Hamburguesa extends StatefulWidget {
  @override
  _HamburguesaState createState() => _HamburguesaState();
}

class _HamburguesaState extends State<Hamburguesa> {
    bool isCollapsed = true;
    double screenWidth, screenHeight;
    final Duration duration = const Duration(milliseconds: 500);
    AnimationController _controller;

    AppBar appBar = AppBar();
    double borderRadius = 0.0;

    int _navBarIndex = 0;
    TabController tabController;
  Widget build(BuildContext context) {
    return Scaffold(
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
                //child: dashboard(context)),
                child: Container(
                  
                ),
            ),
          ],
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
                Navigator.pushNamed(
              context,"/perfil"
            );
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
                Navigator.pushNamed(
              context,"/busqueda"
            );
          },
            ),
            ListTile(
              title: Text('Log Out'),
              leading: Icon(Icons.exit_to_app),
              onTap: () {
                Navigator.pushNamed(
              context,"/"
            );
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


}