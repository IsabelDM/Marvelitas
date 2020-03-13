import 'package:flutter/material.dart';
import 'package:gsimarvelitas/ui/login_page.dart';
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
      //home: new Resultados(),
      home: new LoginPage(),
      // routes: <String, WidgetBuilder>{

      //}
    );
  }
}
