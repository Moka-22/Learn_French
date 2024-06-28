import 'package:flutter/material.dart';

import '../models/lessons_model.dart';
import '../models/questions_model.dart';
import '../themes/colors.dart';
import '../widgets/info_widget/section_name_widget.dart';
import 'lesson_quiz.dart';

class ThirdGradeQuizScreen extends StatefulWidget {
  const ThirdGradeQuizScreen({super.key});

  @override
  State<ThirdGradeQuizScreen> createState() => _ThirdGradeQuizScreenState();
}

class _ThirdGradeQuizScreenState extends State<ThirdGradeQuizScreen> {
  final List<Lesson> _lessons  =[
    Lesson(
      lessonIndex: 0,
      title: 'Lesson 4: Animals',
      questions: [
        Question(
          question: 'What is the French word for "cat"?',
          options: ['Chien', 'Chat', 'Oiseau', 'Souris'],
          correctAnswer: 'Chat',
        ),
        Question(
          question: 'What is the French word for "dog"?',
          options: ['Chien', 'Chat', 'Oiseau', 'Souris'],
          correctAnswer: 'Chien',
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SectionNameWidget(title: '3 Secondary Quiz'),
            const SizedBox(height: 15,),
            Expanded(
              child: ListView.builder(
                itemCount: _lessons.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: backGroundColor,
                    child: ListTile(
                      title: Text(_lessons[index].title, style: TextStyle(color: Colors.black),),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LessonQuizScreen(lesson: _lessons[index]),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
