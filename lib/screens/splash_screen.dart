import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learnfrenchwithmsuibrahim/widgets/screens_widget/splash_screen_widget.dart';

import 'home_screen.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToHomeScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashScreenWidget(),
    );
  }

  void navigateToHomeScreen() {
    Future.delayed(
      const Duration(seconds: 2),
      () {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => StreamBuilder(
                stream: FirebaseAuth.instance.userChanges(),
                builder: (context, snapshot) {
                  final user = snapshot.data;
                  if (user != null) {
                    return HomeScreen();
                  } else {
                    return LoginScreen();
                  }
                }),
          ),
          (route) => false,
        );
      },
    );
  }
}
