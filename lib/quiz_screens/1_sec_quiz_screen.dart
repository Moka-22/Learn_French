import 'package:flutter/material.dart';
import 'package:learnfrenchwithmsuibrahim/models/questions_model.dart';
import 'package:learnfrenchwithmsuibrahim/themes/colors.dart';
import 'package:learnfrenchwithmsuibrahim/widgets/info_widget/section_name_widget.dart';
import 'package:learnfrenchwithmsuibrahim/models/lessons_model.dart'; // Ensure you import the correct model
import 'lesson_quiz.dart';

class FirstGradeQuizScreen extends StatefulWidget {
  const FirstGradeQuizScreen({super.key});

  @override
  State<FirstGradeQuizScreen> createState() => _FirstGradeQuizScreenState();
}

class _FirstGradeQuizScreenState extends State<FirstGradeQuizScreen> {
  final List<Lesson> _lessons = [
    Lesson(
      lessonIndex: 0,
      title: 'Lesson 1: Alphabet',
      questions: [
        Question(
          question: 'What is the French alphabet?',
          options: ['A-Z', 'A-Y', 'A-X', 'A-W'],
          correctAnswer: 'A-Z',
        ),
        Question(
          question: 'What is the French word for "hello"?',
          options: ['Bonjour', 'Salut', 'Au revoir', 'Merci'],
          correctAnswer: 'Bonjour',
        ),
      ],
    ),
    Lesson(
      lessonIndex: 1,
      title: 'Lesson 2: Numbers',
      questions: [
        Question(
          question: 'What is the French word for "one"?',
          options: ['Un', 'Deux', 'Trois', 'Quatre'],
          correctAnswer: 'Un',
        ),
        Question(
          question: 'What is the French word for "two"?',
          options: ['Un', 'Deux', 'Trois', 'Quatre'],
          correctAnswer: 'Deux',
        ),
      ],
    ),
    // Add more lessons as needed...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SectionNameWidget(title: '1 Secondary Quiz'),
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
