import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;

class ProfilePageDesign extends StatefulWidget {
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
            Text("Leonardo Dicaprio", style: _style(),),
            SizedBox(height: 16,),

            Text("Email", style: _style(),),
            SizedBox(height: 4,),
            Text("bestperritoever@guau.com"),
            SizedBox(height: 16,),

            Text("Localidad", style: _style(),),
            SizedBox(height: 4,),
            Text("Ciudad Real, Spain"),
            SizedBox(height: 16,),

            Text("Idioma", style: _style(),),
            SizedBox(height: 4,),
            Text("Perruno, un poco español tb"),
            SizedBox(height: 16,),

            Divider(color: Colors.black,)
          ],
        ),
      ),
    );
  }
}


final String foto = 'assets/dicaprio.jpg';

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
          color: Colors.red,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.menu, color: Colors.white,),
                  onPressed: (){},
                ),

                Text("Perfil", style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),),

                IconButton(
                  icon: Icon(Icons.notifications, color: Colors.white,),
                  onPressed: (){},
                )
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[

                Column(
                  children: <Widget>[
                    Image(
                      image: AssetImage('assets/dicaprio.jpg'),
                      height: 150,
                      width: 200,
                    ),
                    SizedBox(height: 16,),
                    Text("Leonardo Dicaprio", style: TextStyle(
                      color: Colors.white,
                      fontSize: 20
                    ),)
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
                  padding: const EdgeInsets.fromLTRB(0, 24, 16, 0),
                  child: Transform.rotate(
                    angle: (math.pi * 0.05),
                    child: Container(
                      width: 110,
                      height: 32,
                      child: Center(child: Text("Editar Perfil"),),
                      decoration: BoxDecoration(
                        color: Colors.white,
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