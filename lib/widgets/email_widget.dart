import 'package:flutter/material.dart';
import 'package:playlist_app/screens/detail_screen.dart';
import '../models/email.dart';

class EmailWidget extends StatelessWidget {
  final Email email;
  final VoidCallback onDelete;
  final VoidCallback onMarkAsRead;

  EmailWidget({
    required this.email,
    required this.onDelete,
    required this.onMarkAsRead,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(email.id.toString()),
      background: Container(
        color: Colors.red,
        child: Icon(Icons.delete, color: Colors.white),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        onDelete();
      },
      child: ListTile(
        leading: CircleAvatar(
          child: Text(email.from[0].toUpperCase()),
          backgroundColor: Colors.blue,
        ),
        title: Text(
          email.subject,
          style: TextStyle(
            fontWeight: email.read ? FontWeight.normal : FontWeight.bold,
          ),
        ),
        subtitle: Text(
          '${email.from} - ${email.dateTime.toString().substring(0, 16)}',
          style: TextStyle(
            color: email.read ? Colors.grey : Colors.black,
          ),
        ),
        trailing: email.read
            ? Icon(Icons.mail_outline, color: Colors.grey)
            : Icon(Icons.mail, color: Colors.blue),
        onLongPress: onMarkAsRead,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailScreen(email: email),
            ),
          );
        },
      ),
    );
  }
}
