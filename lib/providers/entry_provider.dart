import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edupot/models/exam.dart';
import 'package:flutter/material.dart';

class EntryProvider extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  List<ExamModel> _exams = [];

  List<ExamModel> get exams => _exams;

  Future<bool> fetchExams(String userId) async {
    try {
      final data =
          await _db.collection('entry').doc(userId).collection("exams").get();
      _exams = data.docs.map((doc) => ExamModel.fromDoc(doc)!).toList();
      notifyListeners();
      return true;
    } catch (e) {
      log(e.toString(),
          name: "Error", level: 2000, error: e, stackTrace: StackTrace.current);
      return false;
    }
  }
}
