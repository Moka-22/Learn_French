import 'package:flutter/material.dart';
import 'package:learnfrenchwithmsuibrahim/widgets/themes_widget/image_widget.dart';

import '../text_widgets/primary_text_widget.dart';

class SplashScreenWidget extends StatelessWidget {
  const SplashScreenWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              const ImageWidget(),
              const SizedBox(
                height: 50,
              ),
              const TextWidget(
                text: 'Apprenez le français avec Msu Ibrahim',
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              const TextWidget(
                text: 'تعلم الفرنسيه مع مسيو ابراهيم',
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const TextWidget(
                text: 'Powered By Eslam Amr',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
