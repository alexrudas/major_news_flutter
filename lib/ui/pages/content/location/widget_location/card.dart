// import 'package:flutter/material.dart';

// class AppCard extends StatelessWidget {
//   final Widget? topLeftWidget, topRightWidget, content, extraContent;
//   final String title;

//   // AppCard constructor
//   const AppCard(
//       {Key? key,
//       required this.title,
//       this.content,
//       this.topLeftWidget,
//       this.topRightWidget,
//       this.extraContent})
//       : super(
//           key: key,
//         );

//   // Building basic card style
//   // With the option to modify its content
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 3, // elevation es la sombra de la tarjeta
//       child: Container(
//         padding: const EdgeInsets.only(
//             top: 4.0, bottom: 16.0, left: 8.0, right: 8.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Row(
//               children: [
//                 // Caja para icono Geolicalización a la izquierda
//                 topLeftWidget != null
//                     ? topLeftWidget!
//                     : const SizedBox(
//                         width: 48.0,
//                       ),
//                 Expanded(
//                   child: Text(
//                     // Texto "Mi Ubicación" en el centro
//                     title,
//                     textAlign: TextAlign.center,
//                     style: Theme.of(context).textTheme.headline6,
//                   ),
//                 ),
//                 topRightWidget !=
//                         null // Caja para icono actualizar a la izquierda
//                     ? topRightWidget!
//                     : const SizedBox(
//                         width: 48.0,
//                       ),
//               ],
//             ),
//             const SizedBox(
//               height: 6.0,
//             ),
//             if (content != null)
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 4.0),
//                 child: content,
//               ),
//             if (extraContent != null)
//               Padding(
//                 padding: const EdgeInsets.only(top: 18.0),
//                 child: extraContent,
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
