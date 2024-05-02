import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'exam.freezed.dart';

@freezed
class ExamModel with _$ExamModel {
  const factory ExamModel({
    String? id,
    int? priority,
    required String title,
    required String description,
    required DateTime finalDate,
  }) = _ExamModel;

  static ExamModel? fromDoc(DocumentSnapshot document) {
    final data = document.data() as Map<String, dynamic>?;

    final Timestamp timestamp = data!["finalDate"];
    final DateTime finalDate = timestamp.toDate();

    return ExamModel(
      id: document.id,
      title: data["title"],
      description: data["description"],
      finalDate: finalDate,
      priority: data["priority"] ?? 1,
    );
  }

  static Map<String, dynamic> toDoc(ExamModel examModel) {
    return {
      "title": examModel.title,
      "description": examModel.description,
      "finalDate": Timestamp.fromDate(examModel.finalDate),
      "priority": examModel.priority ?? 1,
    };
  }
}
