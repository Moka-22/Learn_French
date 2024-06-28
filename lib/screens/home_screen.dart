import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:learnfrenchwithmsuibrahim/themes/colors.dart';
import 'package:learnfrenchwithmsuibrahim/themes/icons.dart';
import 'package:learnfrenchwithmsuibrahim/widgets/drawer_widget/drawer_widget.dart';

import '../navigation_screen/favorites_screen.dart';
import '../navigation_screen/main_screen.dart';
import '../navigation_screen/notifications_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> _screens() {
    return [
      MainScreen(),
      FavoritesScreen(),
    ];
  }

  List<String> titles = [
    'Home',
    'Favorite',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _screenIndex = index;
    });
  }

  int _screenIndex = 0;
  int _notificationCount = 0;
  List<RemoteMessage> _notifications = [];

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.instance.getToken().then((token) {
      print('Token: $token');
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }

      setState(() {
        _notificationCount++;
        _notifications.add(message);
      });
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                NotificationsScreen(notifications: _notifications)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titles[_screenIndex]),
        centerTitle: true,
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            NotificationsScreen(notifications: _notifications)),
                  );
                  setState(() {
                    _notificationCount = 0;
                  });
                },
                icon: notificationIcon,
              ),
              _notificationCount > 0
                  ? Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          _notificationCount.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ],
      ),
      drawer: MenuDrawer(),
      // Screens to navigate
      body: _screens()[_screenIndex],
      // Navigation Buttons
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: sColor,
        elevation: 0.0,
        type: BottomNavigationBarType.fixed,
        currentIndex: _screenIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_filled,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border_outlined),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
