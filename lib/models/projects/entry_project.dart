import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'entry_project.freezed.dart';

@freezed
class EntryProjectModel with _$EntryProjectModel {
  const factory EntryProjectModel({
    required List<DocumentReference<Map<String, dynamic>>>? projects,
  }) = _EntryProjectModel;

  static EntryProjectModel? fromDoc(DocumentSnapshot document) {
    final data = document.data() as Map<String, dynamic>?;
    if (data == null) {
      return const EntryProjectModel(projects: []);
    } else {
      return EntryProjectModel(
        projects: (data["projects"] as List)
            .map((item) => item as DocumentReference<Map<String, dynamic>>)
            .toList(),
      );
    }
  }

  static Map<String, dynamic> toDoc(EntryProjectModel entryProjectModel) {
    return {
      "projects": entryProjectModel.projects,
    };
  }
}
