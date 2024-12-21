import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'quiz.freezed.dart';

enum AnswerType {
  quiz,
  trueFalse,
  fillIn,
}

@freezed
class QuizModel with _$QuizModel {
  const factory QuizModel({
    String? uid,
    required String title,
    required bool isPublic,
    required List<String> questions,
    required List<String> answerTypes,
    required List<List<String>> answers,
    required List<List<String>> correctAnswers,
    required List<int> times,
  }) = _QuizModel;

  static QuizModel? fromDoc(DocumentSnapshot document) {
    final data = document.data() as Map<String, dynamic>;

    return QuizModel(
        uid: document.id,
        title: data["title"] ?? '',
        isPublic: data["isPublic"] ?? false,
        questions: List<String>.from(data["questions"] ?? []),
        answerTypes: List<String>.from(data["answerTypes"] ?? []),
        answers: (data["answers"] as List<dynamic>? ?? [])
            .map((ansList) => List<String>.from(ansList))
            .toList(),
        correctAnswers: (data["correctAnswers"] as List<dynamic>? ?? [])
            .map((ansList) => List<String>.from(ansList))
            .toList(),
        times: List<int>.from(data["times"] ?? []));
  }

  static Map<String, dynamic> toDoc(QuizModel quizmodel) {
    return {
      "title": quizmodel.title,
      "isPublic": quizmodel.isPublic,
      "questions": quizmodel.questions,
      "answerTypes": quizmodel.answerTypes,
      "answers": quizmodel.answers,
      "correctAnswers": quizmodel.correctAnswers,
      "times": quizmodel.times,
    };
  }
}
