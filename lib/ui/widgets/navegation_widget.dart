import 'package:app_majpr_new/domain/use_case/controller_use_case/authentication_controller.dart';
import 'package:app_majpr_new/domain/use_case/controller_use_case/connectivity_controller.dart';
import 'package:app_majpr_new/domain/use_case/theme_manager.dart';
import 'package:app_majpr_new/ui/pages/authentication/user_update/user_update.dart';
import 'package:app_majpr_new/ui/pages/content/chats/chat_page.dart';
import 'package:app_majpr_new/ui/pages/content/location/location_screen.dart';
import 'package:app_majpr_new/ui/pages/content/publication/publication_page.dart';
import 'package:app_majpr_new/ui/pages/content/state_page/state_screen.dart';
import 'package:app_majpr_new/ui/pages/content/home/widget_home/home_news.dart';
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

  @override
  Widget build(BuildContext context) {
    ConnectivityController connectivityController =
        Get.find<ConnectivityController>();
    final AuthenticationController authenticationController = Get.find();
    return DefaultTabController(
      length: 5,
      child: Scaffold(
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
          // Botones del Tabbar
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.menu_book_rounded),
              ),
              Tab(
                icon: Icon(Icons.group_outlined),
              ),
              Tab(
                icon: Icon(Icons.access_time),
              ),
              Tab(
                icon: Icon(Icons.place_outlined),
              ),
              Tab(
                icon: Icon(Icons.chat_bubble),
              ),
            ],
          ),
          //title: Text('Major News'),
        ),
        body: TabBarView(
          children: [
            Obx(
              () => (connectivityController.connected)
                  ? HomeNews()
                  : Center(
                      child: Icon(Icons.wifi_off),
                    ),
            ),
            Obx(
              () => (connectivityController.connected)
                  ? StateScreen()
                  : Center(
                      child: Icon(Icons.wifi_off),
                    ),
            ),
            Obx(
              () => (connectivityController.connected)
                  ? PublicationPage()
                  : Center(
                      child: Icon(Icons.wifi_off),
                    ),
            ),
            Obx(
              () => (connectivityController.connected)
                  ? Locations()
                  : Center(
                      child: Icon(Icons.wifi_off),
                    ),
            ),
            Obx(
              () => (connectivityController.connected)
                  ? UserMessages()
                  : Center(
                      child: Icon(Icons.wifi_off),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
