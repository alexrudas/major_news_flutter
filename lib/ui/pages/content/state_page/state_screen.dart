import 'package:app_majpr_new/domain/models/state_model.dart';
import 'package:app_majpr_new/domain/use_case/controller_use_case/authentication_controller.dart';
import 'package:app_majpr_new/domain/use_case/controller_use_case/connectivity_controller.dart';
import 'package:app_majpr_new/domain/use_case/controller_use_case/state_controller.dart';
import 'package:app_majpr_new/ui/pages/content/state_page/widget_state/card_my_state_widget.dart';
import 'package:app_majpr_new/ui/pages/content/state_page/widget_state/card_state_widget.dart';
import 'package:app_majpr_new/ui/widgets/text_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

final _formKey = GlobalKey<FormState>();
final TextEditingController textcontroller =
    TextEditingController(); // Contrla el texto que se esta escribiendo

class StateScreen extends StatelessWidget {
  const StateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StateController controller = Get.find();
    controller.getLastState();
    AuthenticationController authController = Get.find();
    final media = MediaQuery.of(context).size;
    Stream<QuerySnapshot<Map<String, dynamic>>> statusesStream =
        controller.statusManager.getstateStream();
    ConnectivityController connectivityController = Get.find();
    return Scaffold(
        //Botón flotante
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              //Muestra modal (Dialogo)
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Stack(
                        clipBehavior: Clip.none,
                        children: <Widget>[
                          Positioned(
                            right: -40.0,
                            top: -40.0,
                            child: InkResponse(
                              onTap: () {
                                Get.back();
                              },
                              // Círculo para cerrar el modal
                              child: CircleAvatar(
                                child: Icon(Icons.close),
                                backgroundColor: Colors.red,
                              ),
                            ),
                          ),

                          //Crea Modal Crear Nuevo Estado
                          Form(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Center(
                                  child: Text('Nuevo estado'),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: TextField(
                                      controller: textcontroller,
                                      decoration: InputDecoration(
                                        hintText: 'Escribe tu estado',
                                        labelStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 17,
                                            fontFamily: 'AvenirLight'),
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    child: Text("Guardar Estado"),
                                    onPressed: () {
                                      DateFormat format =
                                          DateFormat('MMMM-dd-yyyy / hh:mm a');
                                      DateTime newDate = DateTime.now();
                                      String date = format.format(newDate);

                                      // Utlizamos el método para mostrar el estado y la fecha
                                      controller.guardarEstado(
                                          textcontroller.text, date);

                                      //Agrega mis estados en la vista Mis Estados
                                      controller.addState(
                                          uid: authController.userActive!.id,
                                          userName: authController
                                              .userActive!.userName,
                                          message: textcontroller.text,
                                          date: date,
                                          avatarLink:
                                              "https://i1.sndcdn.com/avatars-000396582750-afqhbt-t240x240.jpg");
                                      textcontroller.text = "";
                                      Get.back(); // Lleva a la vista cuando se Guarda
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            }),
        body: Column(children: [
          // Barra naranja nombre de la página donde está el usuario
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 3, top: 3),
            width: media.width,
            color: Colors.orange,
            child: Text("Estados",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                )),
          ),
          //Este Container crea la Tarjeta (Card) del Esatdo del usuario
          Obx(
            // se hace observable para que cada vez que haya un nuevo estdo lo agregue a la card
            () => Card(
              elevation: 8,
              child: CardMyStateWidget(
                userName: authController.userActive!.userName,
                message: controller.lastState,
                avatarLink: authController.userActive!.avatarLink,
                date: controller.lastDate,
              ),
            ),
          ),

          Container(
            //color: Colors.white, // color del contenedor
            margin: EdgeInsets.only(left: 0, right: 250, top: 0, bottom: 0),
            padding: EdgeInsets.only(bottom: 10, top: 10),
            child: WidgetText(
                content: "Recientes",
                size: 17,
                color: Colors.grey.shade700,
                fontWeight: FontWeight.normal),
          ),

          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: statusesStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.hasData) {
                  final items =
                      controller.statusManager.extractstate(snapshot.data!);
                  print(items);
                  return ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      StateModel status = items[index];
                      return Card(
                        child: CardStateWidget(
                          userName: status.userName,
                          message: status.message,
                          avatarLink: status.avatarLink,
                          date: status.date,
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('Something went wrong: ${snapshot.error}');
                }

                // By default, show a loading spinner.
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ]));
  }
}
