import 'package:flutter/material.dart';
import 'package:gsimarvelitas/ui/busqueda_page.dart';
import 'package:gsimarvelitas/ui/login_page.dart';

import 'package:gsimarvelitas/ui/profile_page_design.dart';
import 'package:gsimarvelitas/ui/resultados.dart';
import 'package:gsimarvelitas/MenuHamburguesa/sidebarLayout.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'gsimarvelitas',
      theme: new ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.red[800],
        primarySwatch: Colors.red,
      ),
      routes: <String, WidgetBuilder>{
        "/inicio": (BuildContext context) => LoginPage(),
        "/busqueda": (BuildContext context) => BusquedaPage(),
        "/resultados": (BuildContext context) => Resultados(),
        "/perfil": (BuildContext context) => ProfilePageDesign(),
      },
      home: SideBarLayout(),
    );
  }
}
