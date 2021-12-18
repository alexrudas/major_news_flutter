import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatCard extends StatelessWidget {
  final String pictureUrl, name, message;
  final String time;
  final VoidCallback onTap;

  // ChatCard constructor
  const ChatCard(
      {Key? key,
      required this.pictureUrl,
      required this.name,
      required this.message,
      required this.time,
      required this.onTap})
      : super(key: key);

  // We create a Stateless widget that contais an AppCard,
  // Passing all the customizable views as parameters
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        dense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        leading: SizedBox(
          height: 42.0,
          width: 42.0,
          child: Center(
            child: CircleAvatar(
              minRadius: 21.0,
              maxRadius: 21.0,
              backgroundImage: NetworkImage(pictureUrl),
            ),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: Text(
            name,
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
        subtitle: Text(
          message,
          softWrap: false,
          overflow: TextOverflow.fade,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        trailing: Text(
          time,
          style:
              Theme.of(context).textTheme.headline2!.copyWith(fontSize: 12.0),
        ),
        onTap: onTap,
      ),
    );
  }


}
