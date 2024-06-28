import 'package:flutter/material.dart';

import '../models/lessons_model.dart';
import '../models/questions_model.dart';
import '../themes/colors.dart';
import '../widgets/info_widget/section_name_widget.dart';
import 'lesson_quiz.dart';

class SecondGradeQuizScreen extends StatefulWidget {
  const SecondGradeQuizScreen({super.key});

  @override
  State<SecondGradeQuizScreen> createState() => _SecondGradeQuizScreenState();
}

class _SecondGradeQuizScreenState extends State<SecondGradeQuizScreen> {
  final List<Lesson> _lessons = [
    Lesson(lessonIndex: 0, title: 'Lesson 3: Colors', questions: [
      Question(
        question: 'What is the French word for "red"?',
        options: ['Rouge', 'Vert', 'Bleu', 'Jaune'],
        correctAnswer: 'Rouge',
      ),
      Question(
        question: 'What is the French word for "blue"?',
        options: ['Rouge', 'Vert', 'Bleu', 'Jaune'],
        correctAnswer: 'Bleu',
      ),
    ]),
  ];
  // Add more lessons as needed...

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SectionNameWidget(title: '2 Secondary Quiz'),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _lessons.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: backGroundColor,
                    child: ListTile(
                      title: Text(
                        _lessons[index].title,
                        style: TextStyle(color: Colors.black),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                LessonQuizScreen(lesson: _lessons[index]),
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
