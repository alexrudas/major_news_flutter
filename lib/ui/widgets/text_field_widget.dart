import 'package:flutter/material.dart';

class WidgetTextField extends StatelessWidget {
  //constructor evitando que sea nulo
  WidgetTextField(
      {this.keyTextField,
      this.maxLines = 1, // sino recibe ningún valor predefinido será máximo 1
      this.obscureText = false, // Por defecto no oculta con asteriscos al texto
      this.digitsOnly = false, // el formato del teclado sea númerico
      required this.controller, //
      required this.validator,
      required this.helpText});

  Key? keyTextField; // Se declara la variable
  int maxLines;
  bool obscureText;
  bool digitsOnly;
  TextEditingController controller;
  Function validator;
  String helpText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: true,
      key: keyTextField,
      maxLines: maxLines,
      obscureText: obscureText, // ocultar texto Ej, password
      keyboardType: digitsOnly
          ? TextInputType.number
          : TextInputType
              .text, // El ? equiva a un if, los : equivale a un sino.
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        labelText: helpText, // Texto de ayuda al usuario
        labelStyle:
            TextStyle(fontWeight: FontWeight.bold), // estilo de los caracteres
      ),
      controller: controller,
      validator: (value) {
        // Valida que los parametros asignados se cumplan
        return validator(value);
      },
    );
  }
}
