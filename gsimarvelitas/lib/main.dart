import 'package:flutter/material.dart';
import 'package:gsimarvelitas/MenuHamburguesa/sidebarLayout.dart';
import 'package:gsimarvelitas/ui/busqueda_page.dart';
import 'package:gsimarvelitas/ui/login_page.dart';
import 'package:gsimarvelitas/ui/profile_page_design.dart';
import 'package:gsimarvelitas/ui/resultados.dart';
import 'package:gsimarvelitas/ui/lecturaPage.dart';


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
        "/leer": (BuildContext context) => EpubWidget(),
      },
      home: SideBarLayout()
    );
  }
}
/*

//prueba tonta

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  bool _isLoggedIn = false;

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  _login() async{
    try{
      await _googleSignIn.signIn();
      setState(() {
        _isLoggedIn = true;
      });
    } catch (err){
      print(err);
    }
  }

  _logout(){
    _googleSignIn.signOut();
    setState(() {
      _isLoggedIn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        body: Center(
            child: _isLoggedIn
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.network(_googleSignIn.currentUser.photoUrl, height: 50.0, width: 50.0,),
                      Text(_googleSignIn.currentUser.displayName),
                      OutlineButton( child: Text("Logout"), onPressed: (){
                        _logout();
                      },)
                    ],
                  )
                : Center(
                    child: OutlineButton(
                      child: Text("Login with Google"),
                      onPressed: () {
                        _login();
                      },
                    ),
                  )),
      ),
    );
  }
}
*/