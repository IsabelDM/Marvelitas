import "package:flutter/material.dart";

class RutaConfiguracion extends StatelessWidget {
// Variable estática que se usa en main.dart (propiedad routes)
  static const nombreRuta = "/configuracion";
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Configuración de la App"),
          backgroundColor: Colors.redAccent,
        ),
        body: new Container(
            child: new Center(
          child: new Text("Widget de configuración..."),
        )));
  }
}