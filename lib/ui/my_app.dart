import 'package:app_majpr_new/domain/use_case/controller_use_case/authentication_controller.dart';
import 'package:app_majpr_new/ui/widgets/navegation_widget.dart';
import 'package:app_majpr_new/ui/pages/initial_presentation/initial_presentation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// En esta página se crea la lógica de la barra de navegación
class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  AuthenticationController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bottom Navigation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: GetX<AuthenticationController>(
        builder: (controller) {
          if (controller.isLogged.value) {
            return NavegatioWidgetn();
          } else {
            return InitialPresentation();
          }
        },
      ),
    );
  }
}
