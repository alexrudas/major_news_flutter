import 'package:app_majpr_new/domain/use_case/controller_use_case/authentication_controller.dart';
import 'package:app_majpr_new/domain/use_case/controller_use_case/state_controller.dart';
import 'package:app_majpr_new/ui/pages/content/state_page/widget_state/card_state_widget.dart';
import 'package:app_majpr_new/ui/pages/initial_presentation/initial_presentation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyState extends StatefulWidget {
  const MyState({Key? key}) : super(key: key);

  @override
  State<MyState> createState() => _MyStateState();
}

class _MyStateState extends State<MyState> {
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
            child: Text("Mis Estados",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                )),
          ),

          GetX<StateController>(
              // cuerpo de la página Estado (en la App)
              builder: (controller) {
            var myState = controller.listState
                .where((stateModel) =>
                    stateModel.uid == authenticationController.userActive!.id)
                .toList();
            return Expanded(
              child: ListView.builder(
                  itemCount: myState.length, // cuantas cards se van a mostrar
                  itemBuilder: (context, index) {
                    // Aquí itemBuilder actúa como un for
                    return Card(
                        child: CardStateWidget(
                      userName: myState[index].userName,
                      message: myState[index].message,
                      avatarLink: myState[index].avatarLink,
                      date: myState[index].date,
                    ));
                  }),
            );
          }),
        ],
      ),
    );
  }
}
