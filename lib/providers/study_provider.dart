import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edupot/models/learning/quiz.dart';
import 'package:flutter/material.dart';

class StudyProvider extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  List<QuizModel> _quizzes = [];

  List<QuizModel> get quizzes => _quizzes;

  Future<bool> fetchQuizzes(String userId, {bool forceRefresh = false}) async {
    if (!forceRefresh && _quizzes.isNotEmpty) {
      return true;
    }

    try {
      final quizzesFuture =
          _db.collection('users').doc(userId).collection("quizzes").get();

      final results = await quizzesFuture;

      _quizzes = results.docs.map((doc) => QuizModel.fromDoc(doc)!).toList();

      notifyListeners();

      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
