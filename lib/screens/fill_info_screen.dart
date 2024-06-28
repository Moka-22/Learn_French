import 'package:flutter/material.dart';
import 'package:learnfrenchwithmsuibrahim/widgets/screens_widget/fill_info_screen_widget.dart';

class FillInfoScreen extends StatefulWidget {
  const FillInfoScreen({super.key});

  @override
  State<FillInfoScreen> createState() => _FillInfoScreenState();
}

class _FillInfoScreenState extends State<FillInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FillInfoScreenWidget(),
    );
  }
}
