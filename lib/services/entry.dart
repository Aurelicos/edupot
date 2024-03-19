import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edupot/models/entries/exam.dart';
import 'package:edupot/models/entries/task.dart';
import 'package:edupot/models/projects/project.dart';
import 'package:flutter/material.dart';

class EntryService extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<dynamic> setEntry(String userId, dynamic data, String entryType,
      {bool? update}) async {
    try {
      DocumentReference docRef;
      Map<String, dynamic> dataMap;

      if (entryType == 'exam') {
        dataMap = ExamModel.toDoc(data);
      } else if (entryType == 'task') {
        dataMap = TaskModel.toDoc(data);
      } else {
        throw 'Unsupported entry type';
      }

      if (update == true) {
        docRef = _db
            .collection('entry')
            .doc(userId)
            .collection('${entryType}s')
            .doc(data.id);
        await docRef.update(dataMap);
      } else {
        docRef = await _db
            .collection('entry')
            .doc(userId)
            .collection('${entryType}s')
            .add(dataMap);
      }
      return true;
    } catch (e) {
      log(e.toString(),
          name: "Error Creating/Updating $entryType",
          error: e,
          level: 2000,
          stackTrace: StackTrace.current);
      return false;
    }
  }

  Future<dynamic> deleteEntry(String userId, String entryId, String entryType,
      DocumentReference? assigned) async {
    try {
      if (assigned != null) {
        await assigned.update({
          'tasks':
              FieldValue.arrayRemove([_db.doc('entry/$userId/tasks/$entryId')])
        });
      }
      await _db
          .collection('entry')
          .doc(userId)
          .collection('${entryType}s')
          .doc(entryId)
          .delete();
      return true;
    } catch (e) {
      log(e.toString(),
          name: "Error Deleting $entryType",
          error: e,
          level: 2000,
          stackTrace: StackTrace.current);
      return false;
    }
  }

  Future<dynamic> setProject(ProjectModel data, {bool? update}) async {
    try {
      DocumentReference docRef;

      if (update == true) {
        docRef = _db.collection('projects').doc(data.id);
        await docRef.update(ProjectModel.toDoc(data));
      } else {
        docRef = await _db.collection('projects').add(ProjectModel.toDoc(data));
      }
      return true;
    } catch (e) {
      log(e.toString(),
          name: "Error Creating/Updating Project",
          error: e,
          level: 2000,
          stackTrace: StackTrace.current);
      return false;
    }
  }

  Future<Map<String, bool>> assignTasks(String uid, String projectId,
      List<DocumentReference> newRefs, List<DocumentReference> oldRefs) async {
    bool updated = false;

    try {
      final projectRef = _db.collection('projects').doc(projectId);
      final Set<String> oldRefIds = oldRefs.map((ref) => ref.id).toSet();

      for (DocumentReference newTaskRef in newRefs) {
        if (!oldRefIds.contains(newTaskRef.id)) {
          await newTaskRef.update({'assignedProject': projectRef});
          updated = true;
        }
      }

      final Set<String> newRefIds = newRefs.map((ref) => ref.id).toSet();
      for (DocumentReference oldTaskRef in oldRefs) {
        if (!newRefIds.contains(oldTaskRef.id)) {
          await oldTaskRef.update({'assignedProject': FieldValue.delete()});
          updated = true;
        }
      }

      return {
        "success": true,
        "updated": updated,
      };
    } catch (e) {
      log(e.toString(),
          name: "Error Assigning/Unassigning Tasks",
          error: e,
          level: 2000,
          stackTrace: StackTrace.current);
      return {
        "success": false,
        "updated": false,
      };
    }
  }
}
