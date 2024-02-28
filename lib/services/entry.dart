import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edupot/models/entries/exam.dart';
import 'package:edupot/models/entries/task.dart';
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

  Future<dynamic> deleteEntry(
      String userId, String entryId, String entryType) async {
    try {
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
}
