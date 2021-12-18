import 'package:app_majpr_new/domain/use_case/controller_use_case/authentication_controller.dart';
import 'package:app_majpr_new/domain/use_case/controller_use_case/publication_controller.dart';
import 'package:app_majpr_new/ui/pages/content/publication/widget_publication/publication_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

final _formKey = GlobalKey<FormState>();
// Contrlan los textos ingresados
final TextEditingController textcontrollersection = TextEditingController();
final TextEditingController textcontrollertitle = TextEditingController();
final TextEditingController textcontrollermessage = TextEditingController();
final TextEditingController textcontrollerusername = TextEditingController();

class PublicationPage extends StatelessWidget {
  const PublicationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // PublicationController controller = Get.find();
    // AuthenticationController authController = Get.find();
    final media = MediaQuery.of(context).size;
    // Stream<QuerySnapshot<Map<String, dynamic>>> statusesStream =
    //     controller.publicationManager.getpublicationStream();
    return Scaffold(
      // Boton flotante
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            //Add your onPressed code here!
            //Muestra modal (Dialogo)
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                      content:
                          Stack(clipBehavior: Clip.none, children: <Widget>[
                    Positioned(
                      right: -40.0,
                      top: -40.0,
                      child: InkResponse(
                        onTap: () {
                          Get.back();
                        },
                        // circulo Cerrar ventana
                        child: CircleAvatar(
                          child: Icon(Icons.close),
                          backgroundColor: Colors.red,
                        ),
                      ),
                    ),

                    //formulario del Modal Crear Nueva Publicación
                    Form(
                      key: _formKey,
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Center(
                              child: Text('Publicar tu noticia'),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: TextField(
                                  controller: textcontrollersection,
                                  decoration: InputDecoration(
                                    hintText: 'Sección.Ej. Deportes',
                                    labelStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontFamily: 'AvenirLight'),
                                  )),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: TextField(
                                controller: textcontrollertitle,
                                decoration: InputDecoration(
                                  hintText: 'Título de la noticia',
                                  labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontFamily: 'AvenirLight'),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: TextField(
                                  controller: textcontrollermessage,
                                  decoration: InputDecoration(
                                    hintText: 'Contenido de la noticia',
                                    labelStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontFamily: 'AvenirLight'),
                                  )),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: TextField(
                                  controller: textcontrollerusername,
                                  decoration: InputDecoration(
                                    hintText: 'Autor',
                                    labelStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontFamily: 'AvenirLight'),
                                  )),
                            ),
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                    child: Text("Publicar"),
                                    onPressed: () {
                                      DateFormat format =
                                          DateFormat('MMMM-dd-yyyy / hh:mm a');
                                      DateTime newDate = DateTime.now();
                                      String date = format.format(newDate);
                                      PublicationController controller =
                                          Get.find();
                                      controller.addPublication(
                                        uid: "id",
                                        section: textcontrollersection.text,
                                        date: date,
                                        title: textcontrollertitle.text,
                                        message: textcontrollermessage.text,
                                        userName: textcontrollerusername.text,
                                      );
                                      // Aquí vaciamos el formularaio del modal
                                      textcontrollertitle.text = "";
                                      textcontrollersection.text = "";
                                      textcontrollertitle.text = "";
                                      textcontrollermessage.text = "";
                                      textcontrollerusername.text = "";
                                      Get.back();
                                    }))
                          ]),
                    )
                  ]));
                });
          }),

      body: Column(children: [
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(bottom: 3, top: 3),
          width: media.width,
          color: Colors.orange,
          child: Text("Publicaciones",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              )),
        ),
        // Container(
        //   margin: EdgeInsets.only(top: 30),
        //   child: ListView.builder(
        //       itemCount: 1, // cuantas cards se van a mostrar
        //       itemBuilder: (context, index) {
        //         // Aquí itemBuilder actúa como un for
        //         return Card(
        //             child: PublicationWidget(
        //           section: "Economía",
        //           date: "11/12/2021",
        //           title: "Reactivación económica",
        //           userName: "Sander",
        //           message: "Impulso a las ventas por el dá sin iva",
        //         ));
        //       }),
        // ),
        GetX<PublicationController>(
            // cuerpo de la página Estado (en la App)
            builder: (controller) {
          var myPublication = controller.listPublication.toList();
          return Expanded(
            child: ListView.builder(
                itemCount: controller
                    .listPublication.length, // cuantas cards se van a mostrar
                itemBuilder: (context, index) {
                  // Aquí itemBuilder actúa como un for

                  //Return Card importa de PublicationWidget la Card
                  return Card(
                      child: PublicationWidget(
                    section: myPublication[index].section,
                    date: myPublication[index].date,
                    title: myPublication[index].title,
                    message: myPublication[index].message,
                    userName: myPublication[index].userName,
                  ));
                }),
          );
        }),
      ]),
    );
  }
}
