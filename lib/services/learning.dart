import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edupot/models/learning/quiz.dart';
import 'package:flutter/material.dart';

class LearningService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addQuiz(String userId, QuizModel quizModel) async {
    try {
      final quizDoc = QuizModel.toDoc(quizModel);
      await _db
          .collection('users')
          .doc(userId)
          .collection('quizzes')
          .add(quizDoc);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> deleteQuiz(String userId, String quizId) async {
    try {
      await _db
          .collection('users')
          .doc(userId)
          .collection('quizzes')
          .doc(quizId)
          .delete();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
