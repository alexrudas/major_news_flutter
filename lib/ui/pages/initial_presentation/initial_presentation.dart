import 'package:app_majpr_new/ui/pages/authentication/login/login.dart';
import 'package:app_majpr_new/ui/pages/authentication/register/register.dart';
import 'package:app_majpr_new/ui/widgets/bottom_widget.dart';
import 'package:app_majpr_new/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//final _formKey = GlobalKey<FormState>();

class InitialPresentation extends StatefulWidget {
  InitialPresentation({Key? key}) : super(key: key);

  @override
  _PresentationState createState() => _PresentationState();
}

class _PresentationState extends State<InitialPresentation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key('presentationScaffold'),
      body: ListView(
        children: [layout()],
      ),
    );
  }

  // Títulos
  layout() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 60.0, bottom: 5.0),
          child: WidgetText(
              content: "Major News",
              size: 30,
              color: Colors.indigoAccent,
              fontWeight: FontWeight.bold),
        ),
        Padding(
            padding: EdgeInsets.only(top: 10.0, bottom: 1.0),
            child: WidgetText(
                content: "Noticias de interés, breves y precisas",
                size: 20,
                color: Colors.black,
                fontWeight: FontWeight.normal)),
        Padding(
            padding: EdgeInsets.only(top: 2.0, bottom: 20.0),
            child: WidgetText(
                content: "Informarse o publicar tu noticia nunca fue tan fácil",
                size: 16,
                color: Colors.grey,
                fontWeight: FontWeight.normal)),
        widgetPresentationImage(),
        buttons(), //Aquí se llama al método botones para que se visualice
      ],
    );
  }

  // Imagen
  Widget widgetPresentationImage() {
    return Container(
      color: Colors.white,
      // height: MediaQuery.of(context).size.height * 0.33,
      // width: MediaQuery.of(context).size.width,
      child: GestureDetector(
          onTap: () {
            // print('click on edit');
          },
          child: Image(
            image: AssetImage('assets/images/Periodista.jpg'),
            fit: BoxFit.cover,
            //height: ,
            //width: ,
          )),
    );
  }

  //Método botones
  // el Row contine en una misma fila los botones creados
  Widget buttons() {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 40),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          WidgetButton(
              keyButton: Key('keyButtonSignUp'),
              margin: EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              typeMain: true,
              text: "Crear cuenta",
              onPressed: () {
                Get.to(() => SignUp());
              }),
          WidgetButton(
              keyButton: Key('Button_login'),
              margin: EdgeInsets.only(left: 20, right: 20),
              typeMain: true,
              text: "Iniciar sesión",
              // onPressed: () {
              //Add your onPressed code here!
              //Muestra modal (Dialogo)
              //   showDialog(
              //       context: context,
              //       builder: (BuildContext context) {
              //         return AlertDialog(
              //             content:
              //                 Stack(clipBehavior: Clip.none, children: <Widget>[
              //           Positioned(
              //             right: -40.0,
              //             top: -40.0,
              //             child: InkResponse(
              //               onTap: () {
              //                 Get.back();
              //               },
              //               child: CircleAvatar(
              //                 child: Icon(Icons.close),
              //                 backgroundColor: Colors.red,
              //               ),
              //             ),
              //           ),

              //           //formulario del Modal Crear Nueva Publicación
              //           Form(
              //               key: _formKey,
              //               child: Column(
              //                 children: [
              //                   Column(
              //                       mainAxisSize: MainAxisSize.min,
              //                       children: <Widget>[
              //                         Center(
              //                           child: Text('Publicar tu noticia'),
              //                         ),
              //                         Padding(
              //                           padding: EdgeInsets.all(8.0),
              //                           child: TextField(
              //                               controller: textcontrollersection,
              //                               decoration: InputDecoration(
              //                                 hintText: 'Sección.Ej. Deportes',
              //                                 labelStyle: TextStyle(
              //                                     color: Colors.black,
              //                                     fontSize: 17,
              //                                     fontFamily: 'AvenirLight'),
              //                               )),
              //                         ),
              //                         Padding(
              //                           padding: EdgeInsets.all(8.0),
              //                           child: TextField(
              //                             controller: textcontrollertitle,
              //                             decoration: InputDecoration(
              //                               hintText: 'Título de la noticia',
              //                               labelStyle: TextStyle(
              //                                   color: Colors.black,
              //                                   fontSize: 17,
              //                                   fontFamily: 'AvenirLight'),
              //                             ),
              //                           ),
              //                         ),
              //                         Padding(
              //                           padding: EdgeInsets.all(8.0),
              //                           child: TextField(
              //                               controller: textcontrollermessage,
              //                               decoration: InputDecoration(
              //                                 hintText:
              //                                     'Contenido de la noticia',
              //                                 labelStyle: TextStyle(
              //                                     color: Colors.black,
              //                                     fontSize: 17,
              //                                     fontFamily: 'AvenirLight'),
              //                               )),
              //                         ),
              //                         Padding(
              //                           padding: EdgeInsets.all(8.0),
              //                           child: TextField(
              //                               controller: textcontrollerusername,
              //                               decoration: InputDecoration(
              //                                 hintText: 'Autor',
              //                                 labelStyle: TextStyle(
              //                                     color: Colors.black,
              //                                     fontSize: 17,
              //                                     fontFamily: 'AvenirLight'),
              //                               )),
              //                         ),
              //                         Padding(
              //                             padding: const EdgeInsets.all(8.0),
              //                             child: ElevatedButton(
              //                                 child: Text("Publicar"),
              //                                 onPressed: () {
              //                                   DateFormat format =
              //                                       DateFormat('dd-MM-yyyy');
              //                                   DateTime newDate =
              //                                       DateTime.now();
              //                                   String date =
              //                                       format.format(newDate);
              //                                   PublicationController
              //                                       controller = Get.find();
              //                                   controller.addPublication(
              //                                     section: textcontrollersection
              //                                         .text,
              //                                     date: date,
              //                                     title:
              //                                         textcontrollertitle.text,
              //                                     message: textcontrollermessage
              //                                         .text,
              //                                     userName:
              //                                         textcontrollerusername
              //                                             .text,
              //                                   );
              //                                   // Aquí vaciamos el formularaio del modal
              //                                   textcontrollertitle.text = "";
              //                                   textcontrollersection.text = "";
              //                                   textcontrollertitle.text = "";
              //                                   textcontrollermessage.text = "";
              //                                   textcontrollerusername.text =
              //                                       "";
              //                                   Get.back();
              //                                 }))
              //                       ]),
              //                 ],
              //               ))
              //         ]));
              //       });
              // }
              onPressed: () {
                Get.to(() => Login());
              })
        ],
      ),
    );
  }
}
