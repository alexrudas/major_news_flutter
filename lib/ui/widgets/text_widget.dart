import 'dart:ui';

import 'package:flutter/material.dart';

class WidgetText extends StatelessWidget {
  //Las clases inician en Mayúsculas
  final String content; // Las variables inician en minuscular
  final double size; // las variables inician en minuscular
  final Color color; // las variables inician en minuscular
  final FontWeight fontWeight; // las variables inician en minuscular

  const WidgetText({
    Key? key,
    required this.content, // Contenido
    required this.size,
    required this.color,
    required this.fontWeight,
  }) : super(key: key); // constructor de la clase

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      textAlign: TextAlign
          .center, // Alineación del texto con parametros aplicados después del punto.
      style: TextStyle(color: color, fontSize: size, fontWeight: fontWeight),
    );
  }
}
