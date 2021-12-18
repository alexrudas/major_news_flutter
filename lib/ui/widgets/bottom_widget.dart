import 'package:flutter/material.dart';

// NOmbre del widget
class WidgetButton extends StatelessWidget {
  //constructor evitando que sea nulo
  WidgetButton({
    this.keyButton,
    required this.typeMain,
    required this.text,
    required this.onPressed,
    this.margin = const EdgeInsets.all(0),
  });

  Key? keyButton;
  bool typeMain; // Se declara la variable typeMain
  String text; // Se declara la variable text
  Function onPressed; // Se declara la variable onPressed
  EdgeInsets margin; // Se declara la variable

  @override
  Widget build(BuildContext context) {
    // Parece que Expanded esta causando un error, debe utilizarse en un Row o Column
    return Expanded(
      child: Container(
        margin: margin,
        child: ElevatedButton(
          key: keyButton,
          child: Text(text),
          onPressed: () {
            onPressed();
          },
          style: ButtonStyle(
            // Estilo del botón
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            )),
            backgroundColor:
                MaterialStateProperty.all<Color>(typeMain //Color botones
                    ? Color.fromRGBO(75, 117, 241, 1)
                    : Color.fromRGBO(247, 184, 67, 1)),
          ),
        ),
      ),
    );
  }
}

//Botón Swicht

// class SwitchScreen extends StatefulWidget {
//   @override
//   SwitchClass createState() => new SwitchClass();
// }

// class SwitchClass extends State {
//   bool isSwitched = false;
//   var textValue = 'Switch is OFF';

//   void toggleSwitch(bool value) {
//     if (isSwitched == false) {
//       setState(() {
//         isSwitched = true;
//         textValue = 'Switch Button is ON';
//       });
//       print('Switch Button is ON');
//     } else {
//       setState(() {
//         isSwitched = false;
//         textValue = 'Switch Button is OFF';
//       });
//       print('Switch Button is OFF');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//       Transform.scale(
//           scale: 2,
//           child: Switch(
//             onChanged: toggleSwitch,
//             value: isSwitched,
//             activeColor: Colors.blue,
//             activeTrackColor: Colors.yellow,
//             inactiveThumbColor: Colors.redAccent,
//             inactiveTrackColor: Colors.orange,
//           )),
//       Text(
//         '$textValue',
//         style: TextStyle(fontSize: 20),
//       )
//     ]);
//   }
// }
