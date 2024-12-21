import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LearningService extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createQuiz(
      String title,
      bool isPublic,
      List<String> questions,
      List<String> answerTypes,
      List<List<String>> answers,
      List<List<String>> correctAnswers,
      List<int> times) async {
    try {
      await _db.collection('quizzes').add({
        'title': title,
        'isPublic': isPublic,
        'questions': questions,
        'answerTypes': answerTypes,
        'answers': {
          for (var i = 0; i < answers.length; i++) i.toString(): answers[i]
        },
        'correctAnswers': {
          for (var i = 0; i < correctAnswers.length; i++)
            i.toString(): correctAnswers[i]
        },
        'times': times,
      });
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
