import 'package:edupot/models/learning/quiz.dart';
import 'package:flutter/material.dart';

class QuizProvider with ChangeNotifier {
  String _title = '';
  int index = 0;
  bool _isPublic = false;
  final List<String> _questions = [];
  final List<AnswerType> _answerTypes = [];
  final List<List<String>> _answers = [];
  final List<List<String>> _correctAnswers = [];
  final List<int> _times = [];

  String get title => _title;
  bool get isPublic => _isPublic;
  List<String> get questions => List.unmodifiable(_questions);
  List<AnswerType> get answerTypes => List.unmodifiable(_answerTypes);
  List<List<String>> get answers => List.unmodifiable(_answers);
  List<List<String>> get correctAnswers => List.unmodifiable(_correctAnswers);
  List<int> get times => List.unmodifiable(_times);

  void setTitle(String title) {
    _title = title;
    notifyListeners();
  }

  void setIsPublic(bool isPublic) {
    _isPublic = isPublic;
    notifyListeners();
  }

  void setType(int index, AnswerType type) {
    if (index >= 0 && index < _answerTypes.length) {
      _answerTypes[index] = type;
      notifyListeners();
    }
  }

  void addQuestion(String question, AnswerType answerType,
      List<String> answerOptions, List<String> correctAnswers, int time) {
    _questions.add(question);
    _answerTypes.add(answerType);
    _answers.add(answerOptions);
    _correctAnswers.add(correctAnswers);
    _times.add(time);
    notifyListeners();
  }

  void removeQuestion(int index) {
    if (index >= 0 && index < _questions.length) {
      _questions.removeAt(index);
      _answerTypes.removeAt(index);
      _answers.removeAt(index);
      _correctAnswers.removeAt(index);
      _times.removeAt(index);
      notifyListeners();
    }
  }

  void updateQuestion(
    int index, {
    String? question,
    AnswerType? answerType,
    List<String>? answerOptions,
    List<String>? correctAnswers,
    int? time,
  }) {
    if (index >= 0 && index < _questions.length) {
      if (question != null) _questions[index] = question;
      if (answerType != null) _answerTypes[index] = answerType;
      if (answerOptions != null) _answers[index] = answerOptions;
      if (correctAnswers != null) _correctAnswers[index] = correctAnswers;
      if (time != null) _times[index] = time;
      notifyListeners();
    }
  }

  void resetQuiz() {
    _title = '';
    _isPublic = false;
    _questions.clear();
    _answerTypes.clear();
    _answers.clear();
    _correctAnswers.clear();
    _times.clear();
    notifyListeners();
  }
}
