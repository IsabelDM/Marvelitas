import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;

import 'package:gsimarvelitas/MenuHamburguesa/navigationBloc.dart';
import 'package:toast/toast.dart';


class ProfilePageDesign extends StatefulWidget with NavigationStates {
  final Function onMenuTap;

  const ProfilePageDesign({Key key, this.onMenuTap}) : super(key: key);
  @override
  _ProfilePageDesignState createState() => _ProfilePageDesignState();
}

class _ProfilePageDesignState extends State<ProfilePageDesign> {

  @override
  void initState() {
    super.initState();

    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Profile",
      home: ProfilePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ProfilePage extends StatelessWidget {

  TextStyle _style(){
    return TextStyle(
      fontWeight: FontWeight.bold
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            Text("Nombre"),
            SizedBox(height: 4,),
            Text("Jennifer Walters", style: _style(),),
            SizedBox(height: 16,),

            Text("Email", style: _style(),),
            SizedBox(height: 4,),
            Text("bestabogadaever@shulkie.com"),
            SizedBox(height: 16,),

            Text("Localidad", style: _style(),),
            SizedBox(height: 4,),
            Text("Los Ángeles, California"),
            SizedBox(height: 16,),

            Text("Idioma", style: _style(),),
            SizedBox(height: 4,),
            Text("Inglés"),
            SizedBox(height: 16,),
            Divider(color: Colors.black,)
          ],
        ),
      ),
    );
  }
}


//final String foto = 'assets/dicaprio.jpg';

class CustomAppBar extends StatelessWidget
  with PreferredSizeWidget{

  @override
  Size get preferredSize => Size(double.infinity, 320);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyClipper(),
      child: Container(
        padding: EdgeInsets.only(top: 4),
        decoration: BoxDecoration(
          color: Color.fromRGBO(59, 59, 59, 10),
          image: DecorationImage(
          image: AssetImage('assets/hulka.jpg'),
          fit: BoxFit.cover,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 20,
              offset: Offset(0, 0)
            )
          ]
        ),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
            
                IconButton(
                  icon: Icon(Icons.notifications, color: Colors.black,),
                  onPressed: (){
                   Toast.show("No tienes notificaciones", context, duration: Toast.LENGTH_SHORT, gravity: Toast.TOP);
                  },
                )
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[

                Column(
                  children: <Widget>[
                    /*
                    ),)*/
                  ],
                ),  
              ],
            ),
            SizedBox(height: 8,),
            Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: (){
                  print("//TODO: button pulsado");
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 170, 260, 0),
                  child: Transform.rotate(
                    angle: (math.pi * 0.05),
                    child: Container(
                      width: 120,
                      height: 32,
                      child: Center(child: Text("Editar Perfil"),),
                      //child: Center(child: Icon(Icons.edit) ,),
                      decoration: BoxDecoration(
                        color: Colors.lightGreen,
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 20
                          )
                        ]
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path>{

  @override
  Path getClip(Size size) {
    Path p = Path();

    p.lineTo(0, size.height-70);
    p.lineTo(size.width, size.height);

    p.lineTo(size.width, 0);

    p.close();

    return p;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
