import 'package:flutter/material.dart';
import 'package:learnfrenchwithmsuibrahim/themes/colors.dart';
import 'package:learnfrenchwithmsuibrahim/widgets/text_widgets/primary_text_widget.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.text,
    this.onTap,
  });
  final String text;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: primaryColor,
        ),
        child: Center(
          child: TextWidget(
            text: text,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
