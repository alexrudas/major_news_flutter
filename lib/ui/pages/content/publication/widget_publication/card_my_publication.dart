import 'package:flutter/material.dart';

class CardMyPublication extends StatelessWidget {
  String date;
  String title;
  String message;
  String userName;
  Key? keyLisTitle;

  // AppCard constructor
  CardMyPublication(
      {Key? key,
      required this.date,
      required this.title,
      required this.message,
      required this.userName,
      this.keyLisTitle})
      : super(
          key: key,
        );

  // Building basic card style
  // With the option to modify its content
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        padding: const EdgeInsets.only(
            top: 4.0, bottom: 16.0, left: 8.0, right: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
        ),
      ),
    );
  }
}
