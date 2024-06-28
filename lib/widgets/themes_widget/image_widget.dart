import 'package:flutter/material.dart';
import 'package:learnfrenchwithmsuibrahim/themes/images.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({super.key,});



  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 150,
      backgroundImage: AssetImage(logo),
    );
  }
}
