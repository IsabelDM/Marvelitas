import 'package:flutter/material.dart';
import 'package:gsimarvelitas/ui/Seccion.dart';
import 'package:gsimarvelitas/ui/busqueda_page.dart';
import 'package:gsimarvelitas/ui/hamburguesa.dart';
import 'package:gsimarvelitas/ui/login_page.dart';
import 'package:gsimarvelitas/ui/principal.dart';
import 'package:gsimarvelitas/ui/profile_page_design.dart';
import 'package:gsimarvelitas/ui/resultados.dart';



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
       // "/hamburguesa": (BuildContext context) => Hamburguesa(),
        "/hamburguesa": (BuildContext context) => Seccion(),
        "/principal": (BuildContext context) => PrincipalPage(),
   },
      home: LoginPage(),
    );
  }
}
