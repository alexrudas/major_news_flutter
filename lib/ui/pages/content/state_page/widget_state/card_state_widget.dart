import 'package:app_majpr_new/ui/pages/content/state_page/my_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardStateWidget extends StatelessWidget {
  String userName;
  String message;
  String avatarLink;
  String date;
  Key? keyLisTitle;
  final _formKey = GlobalKey<FormState>();

  CardStateWidget(
      {required this.userName,
      required this.message,
      required this.avatarLink,
      required this.date,
      this.keyLisTitle});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: () {
          //Get.to(() => MyState());
        },
        //Botón Borrar
        trailing: IconButton(
            icon: Icon(Icons.delete),
            color: Colors.blue,
            iconSize: 25,
            onPressed: () {
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
                                Navigator.of(context).pop();
                              },
                              child: CircleAvatar(
                                child: Icon(Icons.close),
                                backgroundColor: Colors.red,
                              ),
                            ),
                          ),

                          //Crea Modal Eliminar Publicación
                          Form(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Center(
                                  child: Text('Eliminar Publicación'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    child: Text("Eliminar"),
                                    onPressed: () {
                                      Get.back();
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
            }), // triling ubica el icono a la derecha
        //leading ubica el icono a la izquierda
        leading: Container(
            width: 50,
            height: 100,
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                  width: 6.0,
                ),
                shape: BoxShape.circle,
                image: DecorationImage(image: NetworkImage(avatarLink)))),
        title: Text(userName),
        subtitle: Column(children: [
          Text(message),
          Text(date),
        ]));
  }
}
