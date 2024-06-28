import 'package:flutter/material.dart';
import 'package:learnfrenchwithmsuibrahim/widgets/drawer_widget/about_us_widget.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About Us',
        ),
        centerTitle: true,
      ),
      body: AboutUsWidget(),
    );
  }
}
