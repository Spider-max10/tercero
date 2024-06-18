import 'package:flutter/material.dart';
import '../models/backend.dart';
import '../models/email.dart';
import '../widgets/email_widget.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final Backend _backend = Backend();
  List<Email> _emails = [];

  @override
  void initState() {
    super.initState();
    _emails = _backend.getEmails();
  }

  void _markEmailAsRead(int index) {
    setState(() {
      _backend.markEmailAsRead(_emails[index].id);
    });
  }

  void _deleteEmail(int index) {
    setState(() {
      _backend.deleteEmail(_emails[index].id);
      _emails.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inbox'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _emails = _backend.getEmails();
              });
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _emails.length,
        itemBuilder: (context, index) {
          return EmailWidget(
            email: _emails[index],
            onDelete: () => _deleteEmail(index),
            onMarkAsRead: () => _markEmailAsRead(index),
          );
        },
      ),
    );
  }
}
