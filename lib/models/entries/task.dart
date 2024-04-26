import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'task.freezed.dart';

@freezed
class TaskModel with _$TaskModel {
  const factory TaskModel({
    String? id,
    DocumentReference? assignedProject,
    bool? done,
    required String title,
    required String description,
    required DateTime finalDate,
  }) = _TaskModel;

  static TaskModel? fromDoc(DocumentSnapshot document) {
    final data = document.data() as Map<String, dynamic>?;

    final Timestamp timestamp = data!["finalDate"];
    final DateTime finalDate = timestamp.toDate();

    return TaskModel(
      id: document.id,
      title: data["title"],
      description: data["description"],
      finalDate: finalDate,
      assignedProject: data["assignedProject"],
      done: data["done"] ?? false,
    );
  }

  static Map<String, dynamic> toDoc(TaskModel taskModel) {
    return {
      "title": taskModel.title,
      "description": taskModel.description,
      "finalDate": Timestamp.fromDate(taskModel.finalDate),
      "assignedProject": taskModel.assignedProject,
      "done": taskModel.done ?? false,
    };
  }
}
