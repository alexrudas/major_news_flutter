import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PublicationWidget extends StatelessWidget {
  String section;
  String date;
  String title;
  String message;
  String userName;
  Key? keyLisTitle;
  final _formKey = GlobalKey<FormState>();

  PublicationWidget(
      {required this.section,
      required this.date,
      required this.title,
      required this.message,
      required this.userName,
      this.keyLisTitle});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      trailing: IconButton(
          icon: Icon(Icons.delete),
          color: Colors.blue,
          iconSize: 20,
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
          }),
      // Creación del Avatar leading ubica el icono a la izquierda

      title: Container(
        alignment: Alignment.topLeft,
        margin: EdgeInsets.only(left: 1, right: 0, top: 10, bottom: 10),
        padding: EdgeInsets.only(top: 5, bottom: 5),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title,
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.bold)),
          Text(message,
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.normal))
        ]),
      ),
      subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          section,
          style: TextStyle(fontSize: 15),
        ),
        Text(
          date,
          style: TextStyle(
            fontSize: 15,
          ),
        ),
        Text("Publicado por: " + userName),
      ]),
    );
  }
}
