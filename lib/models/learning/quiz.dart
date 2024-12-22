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
      title: data['title'] ?? '',
      isPublic: data['isPublic'] ?? false,
      questions: List<String>.from(data['questions'] ?? []),
      answerTypes: List<String>.from(data['answerTypes'] ?? []),
      answers: _decodeNestedArray(data['answers'] as List<dynamic>? ?? []),
      correctAnswers:
          _decodeNestedArray(data['correctAnswers'] as List<dynamic>? ?? []),
      times: List<int>.from(data['times'] ?? []),
    );
  }

  static Map<String, dynamic> toDoc(QuizModel quizModel) {
    return {
      "title": quizModel.title,
      "isPublic": quizModel.isPublic,
      "questions": quizModel.questions,
      "answerTypes": quizModel.answerTypes,
      "answers": _encodeNestedArray(quizModel.answers),
      "correctAnswers": _encodeNestedArray(quizModel.correctAnswers),
      "times": quizModel.times,
    };
  }

  static List<Map<String, dynamic>> _encodeNestedArray(
      List<List<String>> nestedArray) {
    return nestedArray
        .map((innerList) =>
            {'values': innerList}) // Každý seznam zabalíme do mapy
        .toList();
  }

  static List<List<String>> _decodeNestedArray(List<dynamic> encodedArray) {
    return encodedArray
        .map((item) =>
            List<String>.from(item['values'] ?? [])) // Extrahujeme hodnoty
        .toList();
  }
}
