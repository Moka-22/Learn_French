import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learnfrenchwithmsuibrahim/sections_screens/1_secondary.dart';
import 'package:learnfrenchwithmsuibrahim/sections_screens/2_secondary.dart';
import 'package:learnfrenchwithmsuibrahim/sections_screens/3_secondary.dart';
import 'package:learnfrenchwithmsuibrahim/sections_screens/quiz.dart';
import 'package:learnfrenchwithmsuibrahim/widgets/info_widget/info_widget.dart';

import '../models/sections_model.dart';
import '../widgets/screens_widget/sections_item_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    super.key,
  });
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  get callbackFunction => null;

  List<CategoryModel> categoryList = [
    CategoryModel(
      title: '1 Secondary',
      image: 'assets/sections/one.jpg',
    ),
    CategoryModel(
      title: '2 Secondary',
      image: 'assets/sections/two.jpg',
    ),
    CategoryModel(
      title: '3 Secondary',
      image: 'assets/sections/three.jpg',
    ),
    CategoryModel(
      title: 'Quiz',
      image: 'assets/sections/Quiz.jpg',
    ),
  ];
  List<Widget> sectionsList = [
    FirstGradeScreen(),
    SecondGradeScreen(),
    ThirdGradeScreen(),
    QuizScreen(),
  ];
  @override
  void initState() {
    super.initState();
    print('My current user ${FirebaseAuth.instance.currentUser}');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // User Info
            InfoWidget(),
            const SizedBox(
              height: 50,
            ),
            // Sections
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 40,
              ),
              itemCount: categoryList.length,
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, i) {
                return SectionsItemWidget(
                    categoryItem: categoryList[i], sections: [sectionsList[i]]);
              },
            ),
          ],
        ),
      ),
    );
  }
}
