import 'package:flutter/material.dart';
import 'package:learnfrenchwithmsuibrahim/sections_screens/quiz.dart';
import '../models/questions_model.dart';

class ReviewAnswersScreen extends StatelessWidget {
  final List<Question> questions;
  final List<String?> selectedAnswers;
  final List<String?> correctAnswers;
  final int score;

  const ReviewAnswersScreen({
    required this.questions,
    required this.selectedAnswers,
    required this.correctAnswers,
    required this.score,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Review Answers'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.push(context,MaterialPageRoute(builder: (_)=> QuizScreen(),));
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: questions.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(questions[index].question),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Selected Answer: ${selectedAnswers[index] ?? 'None'}'),
                  Text('Correct Answer: ${correctAnswers[index]}'),
                  Text(
                    selectedAnswers[index] == correctAnswers[index]
                        ? 'Correct'
                        : 'Incorrect',
                    style: TextStyle(
                      color: selectedAnswers[index] == correctAnswers[index]
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
