import 'package:app_majpr_new/domain/use_case/controller_use_case/authentication_controller.dart';
import 'package:app_majpr_new/ui/pages/authentication/login/login.dart';
import 'package:app_majpr_new/ui/widgets/bottom_widget.dart';
import 'package:app_majpr_new/ui/widgets/text_field_widget.dart';
import 'package:app_majpr_new/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);
  final nombreController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmationController = TextEditingController();
  AuthenticationController authenticationController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key('keySign'),
      appBar: AppBar(
          title: const Text("Major News"),
          leading: IconButton(
              key: Key("backBtn"),
              color: Colors.white,
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.arrow_back))),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(left: 10, right: 10, top: 20),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    alignment: Alignment.topCenter,
                    child: WidgetText(
                        content: "Crea tu cuenta",
                        size: 25,
                        color: Colors.indigoAccent,
                        fontWeight: FontWeight.bold),
                  ),

                  // Caja de texto del nombre
                  Container(
                    margin: EdgeInsets.only(top: 25),
                    child: WidgetTextField(
                      controller: nombreController,
                      helpText: "Nombre",
                      validator: () {},
                      keyTextField: Key(
                          "keyTFname"), // se utiliza al momento de testear para hacer test o pruebas
                    ),
                  ),

                  // Caja de texto del email
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: WidgetTextField(
                      controller: emailController,
                      helpText: "Email",
                      validator: () {},
                      keyTextField: Key(
                          "keyTFemail"), // se utiliza al momento de testear para hacer test o pruebas
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: WidgetTextField(
                      // caja de texto del Password
                      controller: passwordController,
                      helpText: "Contraseña",
                      validator: () {},
                      obscureText: true,
                      keyTextField: Key(
                          "keyTFPassword"), // se utiliza al momento de testear para hacer test o pruebas
                    ),
                  ), //con los parenticis se instancia (se llaman) a los widget

                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: WidgetTextField(
                      // caja de texto Confirmación del Password
                      controller: passwordConfirmationController,
                      helpText: "confirme Contraseña",
                      validator: () {},
                      obscureText: true,
                      keyTextField: Key(
                          "keyTFConfirmPassword"), // se utiliza al momento de testear para hacer test o pruebas
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        WidgetButton(
                            keyButton: Key("keyButtonSignUp"),
                            typeMain: true,
                            text: "Crea tu cuenta",
                            onPressed: () async {
                              try {
                                await authenticationController.signup(
                                    userName: nombreController.text,
                                    email: emailController.text,
                                    password: passwordController.text);
                                Get.back();
                              } catch (e) {
                                print(e);
                              }
                              //Get.to(
                              //() => HomePage(),
                              //); // enruta a la vista deseada, en este caso MenuLateral
                              // if (connectivityController.connected) {
                              //   await controller.manager.signIn(
                              //       email: emailController.text,
                              //       password: passwordController.text);
                              // } else {
                              //   Get.showSnackbar(
                              //     GetBar(
                              //       message: "No estas conectado a la red.",
                              //       duration: const Duration(seconds: 2),
                              //     ),
                              //   );
                              // }},
                            }),
                      ],
                    ),
                  ),
                  // TextButton(
                  //   key: const Key("toSignUpButton"),
                  //   child:
                  //       const Text("¿Aún no tienes una cuenta?    Registrate Aquí"),
                  //   onPressed: widget.onViewSwitch,
                  // ),
                  TextButton(
                    onPressed: () {
                      Get.off(() => Login());
                    },
                    child: const Text(" o  Inicia sesión aquí!"),
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}
