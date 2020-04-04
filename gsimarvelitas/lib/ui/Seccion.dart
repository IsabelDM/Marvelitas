import 'package:flutter/material.dart';
import 'package:gsimarvelitas/ui/busqueda_page.dart';

class Seccion extends StatefulWidget {
  @override
  _RutaHomeState createState() => _RutaHomeState();
}

class _RutaHomeState extends State<Seccion> {
  ListView _listaMenu;
  ListTile _construirItem(
      BuildContext context, IconData iconData, String texto, String ruta) {
    return new ListTile(
        leading: new Icon(iconData),
        title: new Text(texto),
        onTap: () {
          setState(() {
            Navigator.pushNamed(context, ruta);
          });
        });
  }

  ListView _construirListView(BuildContext context) {
    return new ListView(children: <Widget>[
      new DrawerHeader(
        child: new Text("Ajustes"),
      ),
      _construirItem(
          context, Icons.settings, "Configuración", "/configuracion"),
      _construirItem(context, Icons.home, "Home", "/"),
      _construirItem(
          context, Icons.person, "Página de Perfil", "/perfil"),
      new AboutListTile(
        child: new Text("Info"),
        applicationIcon: new Icon(Icons.info),
        icon: new Icon(Icons.info),
        applicationName: "ExpresaOpinion",
        applicationVersion: "v1.0",
      )
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Marvel"),
        backgroundColor: Colors.red,
      ),
      drawer: new Drawer(child: _construirListView(context)),
      body: new BusquedaPage(),
     // body: new VotoDirecto(),
    );
  }
}
