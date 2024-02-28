import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edupot/models/entries/exam.dart';
import 'package:flutter/material.dart';

class EntryService extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<dynamic> setExam(String userId, ExamModel data, {bool? update}) async {
    try {
      if (update == true) {
        await _db
            .collection('entry')
            .doc(userId)
            .collection("exams")
            .doc(data.id)
            .update(ExamModel.toDoc(data));
        return true;
      } else {
        await _db
            .collection('entry')
            .doc(userId)
            .collection("exams")
            .add(ExamModel.toDoc(data));
        return true;
      }
    } catch (e) {
      log(e.toString(),
          name: "Error Creating Exam",
          error: e,
          level: 2000,
          stackTrace: StackTrace.current);
      return false;
    }
  }

  Future<dynamic> deleteExam(String userId, String examId) async {
    try {
      await _db
          .collection('entry')
          .doc(userId)
          .collection("exams")
          .doc(examId)
          .delete();
      return true;
    } catch (e) {
      log(e.toString(),
          name: "Error Deleting Exam",
          error: e,
          level: 2000,
          stackTrace: StackTrace.current);
      return false;
    }
  }
}
