import 'package:app_majpr_new/domain/use_case/controller_use_case/authentication_controller.dart';
import 'package:app_majpr_new/domain/use_case/controller_use_case/publication_controller.dart';
import 'package:app_majpr_new/ui/pages/content/publication/widget_publication/publication_widget.dart';
//import 'package:app_majpr_new/ui/pages/content/state_page/widget_state/card_state_widget.dart';
import 'package:app_majpr_new/ui/pages/initial_presentation/initial_presentation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyPublication extends StatefulWidget {
  const MyPublication({Key? key}) : super(key: key);

  @override
  State<MyPublication> createState() => _MyPublication();
}

class _MyPublication extends State<MyPublication> {
  final nickNameController = TextEditingController();
  final descriptionController = TextEditingController();
  AuthenticationController authenticationController = Get.find();

  // AppBar
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Major News"),
        actions: <Widget>[
          // Widgets que  realizan acciones

          IconButton(
              key: Key("profile"),
              color: Colors.white,
              //size: 20
              onPressed: () {},
              icon: Icon(Icons.account_circle)),

          IconButton(
              key: Key("darkBtn"),
              color: Colors.white,
              onPressed: () {
                Get.changeTheme(
                    Get.isDarkMode ? ThemeData.light() : ThemeData.dark());
              },
              icon: Icon(Icons.brightness_4_rounded)),
          IconButton(
              key: Key("logoutBtn"),
              color: Colors.white,
              onPressed: () {
                AuthenticationController authenticationController = Get.find();
                authenticationController
                    .logout(); // controla que el logout se haya efectuado
                Get.to(() => InitialPresentation());
              },
              icon:
                  Icon(Icons.logout)), // se invoca el icono que se desea crear
        ],
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            Get.back();
          },
        ),
      ),
      extendBodyBehindAppBar: false,
      body: Column(
        children: [
          // campo superior anaranjado "Estados"
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 3, top: 3),
            width: media.width,
            color: Colors.orange,
            child: Text("Mis Publicaciones",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                )),
          ),

          GetX<PublicationController>(
              // cuerpo de la página Estado (en la App)
              builder: (controller) {
            var myPublication = controller.listPublication
                .where((publicationModel) =>
                    publicationModel.uid ==
                    authenticationController.userActive!.id)
                .toList();
            return Expanded(
              child: ListView.builder(
                  itemCount:
                      myPublication.length, // cuantas cards se van a mostrar
                  itemBuilder: (context, index) {
                    // Aquí itemBuilder actúa como un for
                    return Card(
                        child: PublicationWidget(
                      userName: myPublication[index].userName,
                      message: myPublication[index].message,
                      title: myPublication[index].title,
                      date: myPublication[index].date,
                    ));
                  }),
            );
          }),
        ],
      ),
    );
  }
}
