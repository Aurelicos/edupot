import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edupot/models/entries/exam.dart';
import 'package:edupot/models/entries/task.dart';
import 'package:edupot/models/projects/project.dart';
import 'package:edupot/services/notification_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class EntryService extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<dynamic> setEntry(String userId, dynamic data, String entryType,
      {bool? update, DocumentReference? oldAssignee}) async {
    try {
      DocumentReference docRef;
      Map<String, dynamic> dataMap;

      bool updated = false;

      if (entryType == 'exam') {
        dataMap = ExamModel.toDoc(data);
      } else if (entryType == 'task') {
        dataMap = TaskModel.toDoc(data);
      } else {
        throw 'Unsupported entry type';
      }

      DocumentReference? newAssignee;
      if (entryType == 'task') {
        newAssignee = data.assignedProject;
      }

      if (update == true) {
        docRef = _db
            .collection('entry')
            .doc(userId)
            .collection('${entryType}s')
            .doc(data.id);
        await docRef.update(dataMap);

        if (oldAssignee != null &&
            newAssignee != null &&
            oldAssignee.id != newAssignee.id) {
          await oldAssignee.update({
            'tasks': FieldValue.arrayRemove([docRef])
          });
          await newAssignee.update({
            'tasks': FieldValue.arrayUnion([docRef])
          });
          updated = true;
        } else if (oldAssignee == null && newAssignee != null) {
          await newAssignee.update({
            'tasks': FieldValue.arrayUnion([docRef])
          });
          updated = true;
        } else if (oldAssignee != null && newAssignee == null) {
          await oldAssignee.update({
            'tasks': FieldValue.arrayRemove([docRef])
          });
          updated = true;
        }
      } else {
        docRef = await _db
            .collection('entry')
            .doc(userId)
            .collection('${entryType}s')
            .add(dataMap);

        if (newAssignee != null) {
          await newAssignee.update({
            'tasks': FieldValue.arrayUnion([docRef])
          });
          updated = true;
        }
      }

      return {
        "success": true,
        "updated": updated,
      };
    } catch (e) {
      log(e.toString(),
          name: "Error Creating/Updating $entryType",
          error: e,
          level: 2000,
          stackTrace: StackTrace.current);
      return {
        "success": false,
        "updated": false,
      };
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
      NotificationService.cancelAllNotificationsForEvent(entryId);
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

  Future<dynamic> setProject(ProjectModel data,
      {bool? update, String? uid}) async {
    try {
      DocumentReference docRef;

      if (update == true) {
        docRef = _db.collection('projects').doc(data.id);
        await docRef.get().then((docSnapshot) => {
              if (docSnapshot.exists)
                {docRef.update(ProjectModel.toDoc(data))}
              else
                {docRef.set(ProjectModel.toDoc(data))}
            });
      } else {
        docRef = await _db.collection('projects').add(ProjectModel.toDoc(data));
        DocumentReference entryDocRef = _db.collection('entry').doc(uid);
        await entryDocRef.get().then((docSnapshot) => {
              if (docSnapshot.exists)
                {
                  entryDocRef.update({
                    'projects': FieldValue.arrayUnion([docRef])
                  })
                }
              else
                {
                  entryDocRef.set({
                    'projects': FieldValue.arrayUnion([docRef])
                  })
                }
            });
      }
      return docRef.id;
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

      for (DocumentReference newTaskRef in newRefs) {
        DocumentSnapshot taskSnapshot = await newTaskRef.get();
        DocumentReference? currentAssignedProject =
            TaskModel.fromDoc(taskSnapshot)?.assignedProject;

        if (currentAssignedProject != null &&
            currentAssignedProject.id != projectId) {
          await currentAssignedProject.update({
            'tasks': FieldValue.arrayRemove([newTaskRef])
          });
          updated = true;
        }

        await newTaskRef.update({'assignedProject': projectRef});
        updated = true;
      }

      final Set<String> newRefIds = newRefs.map((ref) => ref.id).toSet();
      for (DocumentReference oldTaskRef in oldRefs) {
        if (!newRefIds.contains(oldTaskRef.id)) {
          await oldTaskRef.update({'assignedProject': FieldValue.delete()});
          updated = true;
        }
      }

      return {"success": true, "updated": updated};
    } catch (e) {
      log(e.toString(),
          name: "Error Assigning/Unassigning Tasks",
          error: e,
          level: 2000,
          stackTrace: StackTrace.current);
      return {"success": false, "updated": false};
    }
  }

  Future<dynamic> deleteProject(
      String projectId, List<DocumentReference> tasks, String uid) async {
    try {
      bool updated = false;
      for (DocumentReference taskRef in tasks) {
        DocumentSnapshot taskSnapshot = await taskRef.get();
        if (taskSnapshot.exists) {
          await taskRef.update({'assignedProject': FieldValue.delete()});
          updated = true;
        }
      }

      await _db.collection('projects').doc(projectId).delete();
      await _db.collection('entry').doc(uid).update({
        'projects': FieldValue.arrayRemove([_db.doc('projects/$projectId')])
      });
      NotificationService.cancelAllNotificationsForEvent(projectId);
      return {
        "success": true,
        "updated": updated,
      };
    } catch (e) {
      log(e.toString(),
          name: "Error Deleting Project",
          error: e,
          level: 2000,
          stackTrace: StackTrace.current);
      return {
        "success": false,
        "updated": false,
      };
    }
  }

  Future<bool> markDone(String userId, String entryId,
      {required bool done}) async {
    try {
      await _db
          .collection('entry')
          .doc(userId)
          .collection('tasks')
          .doc(entryId)
          .update({'done': done});
      return true;
    } catch (e) {
      log(e.toString(),
          name: "Error Marking task as Done",
          error: e,
          level: 2000,
          stackTrace: StackTrace.current);
      return false;
    }
  }
}
