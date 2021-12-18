import 'package:app_majpr_new/domain/use_case/controller_use_case/authentication_controller.dart';
import 'package:app_majpr_new/domain/use_case/theme_manager.dart';
import 'package:app_majpr_new/ui/pages/authentication/user_update/user_update.dart';
import 'package:app_majpr_new/ui/pages/chat/chat_page.dart';
import 'package:app_majpr_new/ui/pages/content/location/location_screen.dart';
import 'package:app_majpr_new/ui/pages/content/publication/publication_page.dart';
import 'package:app_majpr_new/ui/pages/content/state_page/state_screen.dart';
import 'package:app_majpr_new/ui/pages/content/home/widget_home/home_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Este archivo permite que tanto el AppBar como el Bottom Navegation se apliquen a todas las páginas

class NavegatioWidgetn extends StatefulWidget {
  const NavegatioWidgetn({Key? key}) : super(key: key);

  @override
  // se crea el estado para saber cual de los taps está abierto
  State<NavegatioWidgetn> createState() => _NavegatioWidgetnState();
}

class _NavegatioWidgetnState extends State<NavegatioWidgetn> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static final List<Widget> _widgetOptions = <Widget>[
    HomeWidget(),
    StateScreen(),
    PublicationPage(),
    LocationScreen(),
    ChatPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final AuthenticationController authenticationController = Get.find();
    return Scaffold(
        drawer: Drawer(
          child: Container(
            //color: Colors.indigo[400],
            child: Column(
              children: [
                Container(
                  width: 150, //ancho de la imagen
                  height: 150, //largo de la imagen
                  margin: const EdgeInsets.all(40),
                  child: const Text("Major News",
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 24,
                          color: Colors.blue)),
                ),
                Container(
                    padding: const EdgeInsets.only(left: 20, bottom: 2, top: 3),
                    width: double.infinity,
                    color: Colors.white,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 20),
                        ),
                        onPressed: () {
                          Get.to(() => UserUpdate());
                        },
                        child: const Text('Perfil   ',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 16)),
                      ),
                    )),
                Container(
                    padding: EdgeInsets.only(left: 20, bottom: 2, top: 3),
                    width: double.infinity,
                    color: Colors.white,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 20),
                        ),
                        child: const Text('Invitar amigos',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 16)),
                        onPressed: () {},
                      ),
                    )),
                Container(
                    padding: const EdgeInsets.only(left: 20, bottom: 2, top: 3),
                    width: double.infinity,
                    color: Colors.white,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 20),
                        ),
                        child: const Text('Cerrar sesión',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 16)),
                        onPressed: () {
                          authenticationController
                              .logout(); // controla el estado del logout
                        },
                      ),
                    )),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          title: const Text("Major News"),
          actions: <Widget>[
            // Widgets que  realizan acciones

            // Botón Perfil de usuario en el AppBar
            IconButton(
                key: Key("profile"),
                color: Colors.white,
                //size: 20
                onPressed: () {
                  Get.to(() => UserUpdate());
                },
                icon: Icon(Icons.account_circle)),

            // Botón modo Dark
            IconButton(
                key: Key("darkBtn"),
                color: Colors.white,
                onPressed: () {
                  ThemeManager themeManager =
                      Get.find(); // llamamos (instanciamos) al ThemeManager
                  themeManager.changeTheme(
                      Get.isDarkMode); // LLamamos al método changeTheme
                },
                icon: Icon(Icons.brightness_4_rounded)),

            // Botón Salir
            IconButton(
                key: Key("logoutBtn"),
                color: Colors.white,
                onPressed: () {
                  authenticationController
                      .logout(); // controla el estado del logout
                },
                icon: Icon(
                    Icons.logout)), // se invoca el icono que se desea crear
          ],
        ),
        body: _widgetOptions.elementAt(_selectedIndex),
        // ítems de la barra con los botones de navegacion
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_book_rounded,
                  key: Key("statesSection"), color: Colors.blue),
              label: 'Noticias',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.group_outlined,
                  key: Key("statelSection"), color: Colors.blue),
              label: 'Estado',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.public_outlined,
                  key: Key("publicationSection"), color: Colors.blue),
              label: 'Publicación',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.place_outlined,
                  key: Key("locationSection"), color: Colors.blue),
              label: 'Ubicación',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline, color: Colors.blue),
              label: 'Chat',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: Colors.amber[800],
        ));
  }
}
