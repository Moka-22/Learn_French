import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  final List<RemoteMessage> notifications;

  const NotificationsScreen({required this.notifications});

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: widget.notifications.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(widget.notifications[index].notification?.title ?? ''),
            subtitle:
                Text(widget.notifications[index].notification?.body ?? ''),
          );
        },
      ),
    );
  }
}
