import 'package:flutter/material.dart';
import '../widgets/drawer_widget/contact_us_widget.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Contact Us',
        ),
        centerTitle: true,
      ),
      body: ContactUsWidget(),
    );
  }
}
