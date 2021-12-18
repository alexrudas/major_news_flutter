import 'package:app_majpr_new/domain/use_case/controller_use_case/authentication_controller.dart';
import 'package:app_majpr_new/ui/pages/authentication/register/register.dart';
import 'package:app_majpr_new/ui/widgets/bottom_widget.dart';
import 'package:app_majpr_new/ui/widgets/text_field_widget.dart';
import 'package:app_majpr_new/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final savecredentials = false.obs; // variable observable (obs)
  final _formKey = GlobalKey<FormState>();
  //final controller = Get.find<AuthController>();
  //final connectivityController = Get.find<ConnectivityController>();

  @override
  Widget build(BuildContext context) {
    final AuthenticationController authenticationController = Get
        .find(); // se creó una instancia para llamar a los métodos de login controler
    return Scaffold(
      key: Key('loginScaffold'),
      appBar: AppBar(
          title: const Text("Major News"),
          leading: IconButton(
              key: Key("backBtn"),
              color: Colors.white,
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.arrow_back))),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(left: 10, right: 10, top: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    alignment: Alignment.topCenter,
                    child: WidgetText(
                        content: "Iniciar sesión",
                        size: 25,
                        color: Colors.indigoAccent,
                        fontWeight: FontWeight.bold),
                  ),

                  // Caja de texto del email
                  Container(
                    margin: EdgeInsets.only(top: 25),
                    child: WidgetTextField(
                      controller: emailController,
                      helpText: "Digite su email",
                      validator: (value) {
                        if (value.isEmpty) {
                          return "El campo del email es requerido";
                        } else if (!value.contains('@')) {
                          return "Enter valid email address";
                        }
                      },
                      keyTextField: Key(
                          "keyTFemail"), // se utiliza al momento de testear para hacer test o pruebas
                    ),
                  ),

                  // caja de texto del Password
                  Container(
                    margin: EdgeInsets.only(top: 25),
                    child: WidgetTextField(
                      controller: passwordController,
                      helpText: "Digite su clave",
                      validator: (value) {
                        if (value.isEmpty) {
                          return "El campo del contraseña es requerida";
                        } else if (value.length < 6) {
                          return "La contraseña debe tener mínimo de 6 caracteres";
                        }
                      },
                      obscureText: true,
                      keyTextField: Key(
                          "keyTFPassword"), // se utiliza al momento de testear para hacer test o pruebas
                    ), //con los parenticis se instancia (se llaman) a los widget
                  ),

                  Row(
                    children: [
                      // Checkbox
                      Obx(
                        () => Checkbox(
                          value: savecredentials.value, //
                          onChanged: (bool? value) {
                            savecredentials.value = value!;
                          },
                        ),
                      ),
                      WidgetText(
                          content: "Recordar mis datos",
                          size: 14,
                          color: Colors.blue,
                          fontWeight: FontWeight.normal)
                    ],
                  ),

                  // Botón
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      WidgetButton(
                          keyButton: Key("Button_Iniciar sesión"),
                          typeMain: true,
                          text: "Iniciar sesión",
                          onPressed: () async {
                            final form = _formKey.currentState;
                            form!.save();
                            if (form.validate()) {
                              try {
                                await authenticationController.login(
                                  emailController.text,
                                  passwordController.text,
                                );
                                Get.back();
                              } catch (e) {
                                //la variable (e) contiene la informacion del error
                                //Cuando haya al gún error, aquí se recibe la información
                                print(e);
                                if (e == 'user-not-found') {
                                  Get.snackbar(
                                    "Usuario no encontrado",
                                    "No se encontró un usuario que use ese email.",
                                  );
                                } else if (e == 'wrong-password') {
                                  Get.snackbar(
                                    "Contraseña equivocada",
                                    "La contraseña proveida por el usuario no es correcta.",
                                  );
                                }
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Error')));
                            }

                            // if (isPass(passwordController.text)) {
                            //   authenticationController.login();

                            // } else {
                            //   Get.snackbar(
                            //       "la contraseña debe ser menor a 6 caracteres",
                            //       "Correo invalido");
                            // }
                            // enruta a la vista deseada, en este caso MenuLateral
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
                  TextButton(
                    onPressed: () {
                      Get.off(() => SignUp());
                    },
                    child: const Text(" o  Crea tu cuenta aquí!"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
