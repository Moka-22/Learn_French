import 'package:learnfrenchwithmsuibrahim/models/questions_model.dart';

class Lesson {
  final int lessonIndex;
  final String title;
  final List<Question> questions;

  Lesson({required this.lessonIndex, required this.title, required this.questions});
}
