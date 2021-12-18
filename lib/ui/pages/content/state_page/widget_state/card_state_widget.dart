import 'package:flutter/material.dart';

class CardStateWidget extends StatelessWidget {
  String userName;
  String message;
  String avatarLink;
  String date;
  Key? keyLisTitle;

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
            alignment: Alignment.topRight,
            icon: Icon(Icons.delete),
            color: Colors.blue,
            iconSize: 20,
            onPressed: () {}), // triling ubica el icono a la derecha
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
