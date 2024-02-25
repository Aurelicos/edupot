import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edupot/models/exam.dart';
import 'package:edupot/models/task.dart';
import 'package:flutter/material.dart';

class EntryProvider extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  List<ExamModel> _exams = [];
  List<TaskModel> _tasks = [];
  DateTime? _lastFetchTime;

  List<ExamModel> get exams => _exams;
  List<TaskModel> get tasks => _tasks;

  Future<Map<String, bool>> fetchEntries(String userId,
      {bool forceRefresh = false}) async {
    if (!forceRefresh &&
        _lastFetchTime != null &&
        DateTime.now().difference(_lastFetchTime!).inMinutes < 15) {
      return {
        "cached": true,
        "success": true,
      };
    }

    try {
      final examsFuture =
          _db.collection('entry').doc(userId).collection("exams").get();
      final tasksFuture =
          _db.collection('entry').doc(userId).collection("tasks").get();

      final results = await Future.wait([examsFuture, tasksFuture]);

      _exams = results[0].docs.map((doc) => ExamModel.fromDoc(doc)!).toList();
      _tasks = results[1].docs.map((doc) => TaskModel.fromDoc(doc)!).toList();
      _lastFetchTime = DateTime.now();

      notifyListeners();
      return {
        "cached": false,
        "success": true,
      };
    } catch (e) {
      log(e.toString(),
          name: "Error Fetching Entries",
          level: 2000,
          error: e,
          stackTrace: StackTrace.current);
      return {
        "cached": false,
        "success": false,
      };
    }
  }
}
