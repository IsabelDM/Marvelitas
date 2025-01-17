import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getflutter/getflutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rxdart/rxdart.dart';
import 'package:toast/toast.dart';
import '../MenuHamburguesa/navigationBloc.dart';
import '../MenuHamburguesa/menuItem.dart';
import 'package:gsimarvelitas/ui/login_page.dart';

class SideBar extends StatefulWidget {
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar>
    with SingleTickerProviderStateMixin<SideBar> {
  AnimationController _animationController;
  StreamController<bool> isSidebarOpenedStreamController;
  Stream<bool> isSidebarOpenedStream;
  StreamSink<bool> isSidebarOpenedSink;
  final _animationDuration = const Duration(milliseconds: 500);
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  bool _isLoggedIn = false;

  _logout() {
    _googleSignIn.signOut();
    setState(() {
      _isLoggedIn = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: _animationDuration);
    isSidebarOpenedStreamController = PublishSubject<bool>();
    isSidebarOpenedStream = isSidebarOpenedStreamController.stream;
    isSidebarOpenedSink = isSidebarOpenedStreamController.sink;
  }

  @override
  void dispose() {
    _animationController.dispose();
    isSidebarOpenedStreamController.close();
    isSidebarOpenedSink.close();
    super.dispose();
  }

  void onIconPressed() {
    final animationStatus = _animationController.status;
    final isAnimationCompleted = animationStatus == AnimationStatus.completed;

    if (isAnimationCompleted) {
      isSidebarOpenedSink.add(false);
      _animationController.reverse();
    } else {
      isSidebarOpenedSink.add(true);
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return StreamBuilder<bool>(
      initialData: false,
      stream: isSidebarOpenedStream,
      builder: (context, isSideBarOpenedAsync) {
        return AnimatedPositioned(
          duration: _animationDuration,
          top: 0,
          bottom: 0,
          left: isSideBarOpenedAsync.data ? 0 : -screenWidth,
          right: isSideBarOpenedAsync.data ? 0 : screenWidth - 36,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  //color: Color.fromRGBO(59 , 59, 59, 10),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(59, 59, 59, 10),
                    image: DecorationImage(
                      image: AssetImage('assets/menu.jpg'),
                      //Si es online:
                      //image: NetworkImage('https://png.pngtree.com/thumb_back/fw800/back_our/20190620/ourmid/pngtree-strong-decontamination-cleaner-promotion-main-map-image_142503.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 75,
                      ),
                      UserAccountsDrawerHeader(
                        accountName: Text("Jennifer Walters",
                            style: TextStyle(fontWeight: FontWeight.bold
                                // color: Colors.black,
                                )),
                        accountEmail: Text("bestabogadaever@shulkie.com",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        currentAccountPicture: new GestureDetector(
                          onTap: () {
                            onIconPressed();
                            BlocProvider.of<NavigationBloc>(context)
                                .add(NavigationEvents.ProfilePageClickedEvent);
                          },
                          child: new CircleAvatar(
                              backgroundImage: AssetImage('assets/hulka.jpg')),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black38,
                        ),
                      ),
                      SizedBox(height: 30,),
                      Container(
                        decoration: BoxDecoration( color: Color.fromRGBO(59, 59, 59, 95),),
                        child: Column(
                          children: <Widget>[
                            MenuItem(
                              title: 'Búsqueda',
                              icon: Icons.search,
                              onTap: () {
                                onIconPressed();
                                BlocProvider.of<NavigationBloc>(context).add(
                                    NavigationEvents.BusquedaPageClickedEvent);
                              },
                            ),
                            MenuItem(
                                title: 'Leer',
                                icon: Icons.description,
                                onTap: () {
                                  onIconPressed();
                                  BlocProvider.of<NavigationBloc>(context).add(
                                      NavigationEvents.LecturaClickedEvent);
                                }),
                            MenuItem(
                              title: 'Ajustes',
                              icon: Icons.settings,
                            ),
                            MenuItem(
                                title: 'About',
                                icon: Icons.info,
                                onTap: () {
                                  Toast.show(
                                      "Aplicación realizada por:\n·Lucía Alfonso\n·Isabel Diezma\n(c) 2020",
                                      context,
                                      duration: Toast.LENGTH_LONG,
                                      gravity: Toast.CENTER);

                                  onIconPressed();
                                  BlocProvider.of<NavigationBloc>(context).add(
                                      NavigationEvents.LecturaClickedEvent);
                                }),
                            MenuItem(
                              title: 'Log Out',
                              icon: Icons.exit_to_app,
                              onTap: () {
                                onIconPressed();
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/', (Route<dynamic> route) => false);
                                _logout();
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0, -0.9),
                child: GestureDetector(
                  onTap: () {
                    onIconPressed();
                  },
                  child: ClipPath(
                    clipper: CustomMenuClipper(),
                    child: Container(
                      width: 35,
                      height: 110,
                      color: Colors.red,
                      alignment: Alignment.centerLeft,
                      child: AnimatedIcon(
                        progress: _animationController.view,
                        icon: AnimatedIcons.menu_close,
                        color: Colors.black,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CustomMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Paint paint = Paint();
    paint.color = Colors.white;

    final width = size.width;
    final height = size.height;

    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(width - 1, height / 2 - 20, width, height / 2);
    path.quadraticBezierTo(width + 1, height / 2 + 20, 10, height - 16);
    path.quadraticBezierTo(0, height - 8, 0, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
