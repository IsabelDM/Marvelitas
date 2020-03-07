import 'package:flutter/material.dart';
import 'package:gsimarvelitas/ui/login_page.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'gsimarvelitas',
      theme: new ThemeData(

        primarySwatch: Colors.red,
      ),
      home: new LoginPage(),
    );
  }
}