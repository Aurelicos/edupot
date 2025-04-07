import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edupot/models/learning/report.dart';
import 'package:flutter/material.dart';

class ReportProvider extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  List<ReportModel> _reports = [];
  bool _isLoading = false;

  List<ReportModel> get reports => _reports;
  bool get isLoading => _isLoading;

  Future<bool> fetchReports(String userId) async {
    _isLoading = true;

    try {
      final querySnapshot = await _db
          .collection('users')
          .doc(userId)
          .collection('reports')
          .orderBy('date', descending: true)
          .get();

      _reports =
          querySnapshot.docs.map((doc) => ReportModel.fromDoc(doc)).toList();

      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addReport(String userId, ReportModel reportModel) async {
    _isLoading = true;

    try {
      await _db
          .collection('users')
          .doc(userId)
          .collection('reports')
          .add(ReportModel.toDoc(reportModel));

      await fetchReports(userId);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteReport(String userId, String reportId) async {
    _isLoading = true;

    try {
      await _db
          .collection('users')
          .doc(userId)
          .collection('reports')
          .doc(reportId)
          .delete();

      await fetchReports(userId);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
