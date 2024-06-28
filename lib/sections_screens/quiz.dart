import 'package:flutter/material.dart';
import 'package:learnfrenchwithmsuibrahim/widgets/info_widget/section_name_widget.dart';

import '../models/sections_model.dart';
import '../quiz_screens/1_sec_quiz_screen.dart';
import '../quiz_screens/2_sec_quiz_screen.dart';
import '../quiz_screens/3_sec_quiz_screen.dart';
import '../widgets/screens_widget/sections_item_widget.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {

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
  ];

  List<Widget> sectionsList = [
    FirstGradeQuizScreen(),
    SecondGradeQuizScreen(),
    ThirdGradeQuizScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SectionNameWidget(title: 'Quiz'),
              const SizedBox(height: 20,),
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
      ),
    );
  }
}
