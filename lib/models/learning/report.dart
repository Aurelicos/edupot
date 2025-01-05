import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'report.freezed.dart';

@freezed
class ReportModel with _$ReportModel {
  const factory ReportModel({
    String? uid,
    required String userId,
    required String quizId,
    required String quizName,
    required int totalQuestions,
    required int correctAnswers,
    required double percentage,
    required DateTime date,
    required List<bool> isCorrect,
  }) = _ReportModel;

  factory ReportModel.fromDoc(DocumentSnapshot document) {
    final data = document.data() as Map<String, dynamic>;
    return ReportModel(
      uid: document.id,
      userId: data['userId'] as String,
      quizId: data['quizId'] as String,
      quizName: data['quizName'] as String,
      totalQuestions: data['totalQuestions'] as int,
      correctAnswers: data['correctAnswers'] as int,
      percentage: (data['percentage'] as num).toDouble(),
      date: (data['date'] as Timestamp).toDate(),
      isCorrect: List<bool>.from(data['isCorrect'] as List<dynamic>),
    );
  }

  static Map<String, dynamic> toDoc(ReportModel reportModel) {
    return {
      'userId': reportModel.userId,
      'quizId': reportModel.quizId,
      'quizName': reportModel.quizName,
      'totalQuestions': reportModel.totalQuestions,
      'correctAnswers': reportModel.correctAnswers,
      'percentage': reportModel.percentage,
      'date': Timestamp.fromDate(reportModel.date),
      'isCorrect': reportModel.isCorrect,
    };
  }
}
