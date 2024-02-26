import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'project.freezed.dart';
part 'project.g.dart';

@freezed
class ProjectModel with _$ProjectModel {
  const factory ProjectModel({
    String? uid,
    required String name,
    required String description,
    required DateTime finalDate,
    required int finished,
    required String iconTitle,
    required List<dynamic> tasks,
  }) = _ProjectModel;

  static ProjectModel? fromDoc(DocumentSnapshot document) {
    final data = document.data() as Map<String, dynamic>?;

    final Timestamp timestamp = data!["finalDate"];
    final DateTime finalDate = timestamp.toDate();

    return ProjectModel(
      uid: document.id,
      name: data["name"],
      description: data["description"],
      finalDate: finalDate,
      finished: data["finished"] ?? 0,
      iconTitle: data["iconTitle"],
      tasks: data["tasks"],
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

  factory ProjectModel.fromJson(Map<String, dynamic> json) =>
      _$ProjectModelFromJson(json);
}
