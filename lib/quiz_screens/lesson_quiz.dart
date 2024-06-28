import 'package:flutter/material.dart';
import 'package:learnfrenchwithmsuibrahim/models/lessons_model.dart';
import 'package:learnfrenchwithmsuibrahim/quiz_screens/review_answers.dart';

class LessonQuizScreen extends StatefulWidget {
  final Lesson lesson;

  const LessonQuizScreen({required this.lesson, Key? key}) : super(key: key);

  @override
  State<LessonQuizScreen> createState() => _LessonQuizScreenState();
}

class _LessonQuizScreenState extends State<LessonQuizScreen> {
  int _currentQuestion = 0;
  int _score = 0;
  String? _selectedAnswer;
  bool _quizFinished = false;
  List<String?> _selectedAnswers = [];

  @override
  Widget build(BuildContext context) {
    if (_currentQuestion < widget.lesson.questions.length && !_quizFinished) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Lesson ${widget.lesson.lessonIndex + 1} Quiz'),
          backgroundColor: Colors.indigo,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                widget.lesson.questions[_currentQuestion].question,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              ...widget.lesson.questions[_currentQuestion].options
                  .map((option) => RadioListTile(
                title: Text(option),
                value: option,
                groupValue: _selectedAnswer,
                onChanged: (value) {
                  setState(() {
                    _selectedAnswer = value as String?;
                  });
                },
              ))
                  .toList(),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.indigo,
                ),
                child: Text('Next'),
                onPressed: () {
                  if (_selectedAnswer != null) {
                    if (_selectedAnswer == widget.lesson.questions[_currentQuestion].correctAnswer) {
                      _score++;
                    }
                    _selectedAnswers.add(_selectedAnswer);
                    setState(() {
                      _selectedAnswer = null;
                      if (_currentQuestion < widget.lesson.questions.length - 1) {
                        _currentQuestion++;
                      } else {
                        _quizFinished = true;
                        _showQuizFinishedDialog(context);
                      }
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please select an answer'),
                      ),
                    );
                  }
                },
              ),
              Text(
                'Score: $_score/${widget.lesson.questions.length}',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(body: Center(child: Text('Quiz finished!')));
    }
  }

  void _showQuizFinishedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Quiz Finished!'),
          content: Text('Your score is $_score/${widget.lesson.questions.length}'),
          actions: [
            ElevatedButton(
              child: Text('Review Answers'),
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                _showReviewAnswersDialog(context); // Show the review answers screen
              },
            ),
            ElevatedButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _showReviewAnswersDialog(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReviewAnswersScreen(
          questions: widget.lesson.questions,
          selectedAnswers: _selectedAnswers,
          correctAnswers: widget.lesson.questions.map((question) => question.correctAnswer).toList(),
          score: _score,
        ),
      ),
    );
  }
}
