import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'project.freezed.dart';

@freezed
class ProjectModel with _$ProjectModel {
  const factory ProjectModel({
    String? id,
    required String name,
    required String description,
    required DateTime finalDate,
    required int finished,
    required String iconTitle,
    required List<DocumentReference> tasks,
  }) = _ProjectModel;

  static ProjectModel? fromDoc(DocumentSnapshot document) {
    final data = document.data() as Map<String, dynamic>?;

    final Timestamp timestamp = data!["finalDate"];
    final DateTime finalDate = timestamp.toDate();

    final List<DocumentReference> tasks = (data["tasks"] as List<dynamic>?)
            ?.whereType<DocumentReference>()
            .map((e) => e)
            .toList() ??
        [];

    return ProjectModel(
      id: document.id,
      name: data["name"],
      description: data["description"],
      finalDate: finalDate,
      finished: data["finished"] ?? 0,
      iconTitle: data["iconTitle"],
      tasks: tasks,
    );
  }

  static Map<String, dynamic> toDoc(ProjectModel projectModel) {
    return {
      "name": projectModel.name,
      "description": projectModel.description,
      "finalDate": Timestamp.fromDate(projectModel.finalDate),
      "finished": projectModel.finished,
      "iconTitle": projectModel.iconTitle,
      "tasks": projectModel.tasks,
    };
  }
}
