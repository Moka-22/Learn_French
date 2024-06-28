import 'package:flutter/material.dart';

import '../widgets/screens_widget/login_screen_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginScreenWidget(),
    );
  }
}
