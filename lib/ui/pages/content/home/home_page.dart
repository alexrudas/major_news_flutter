import 'package:app_majpr_new/domain/use_case/controller_use_case/authentication_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final AuthenticationController authenticationController = Get.find();
    return Scaffold(
      body: ListView(
        children: [
          noticias(),
          noticias(),
          noticias(),
          noticias(),
          noticias(),
          noticias(),
          noticias()
        ],
      ),
    );
  }
}

noticias() {
  return Column(
    children: [
      ListTile(
        leading: Text("Titulo noticias"),
        subtitle: Text("Noticias"),
        trailing: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: 44,
            minHeight: 44,
            maxWidth: 64,
            maxHeight: 64,
          ),
          child: Image.asset('assets/images/Periodista.jpg', fit: BoxFit.cover),
        ),
      ),
      Divider()
    ],
  );
  // trailing: Image(
  //     image: AssetImage('assets/images/Periodista.jpg'), fit: BoxFit.cover),
  // subtitle: Text("Noticias 1"));
}
