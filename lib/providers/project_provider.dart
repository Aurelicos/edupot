import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edupot/models/projects/entry_project.dart';
import 'package:edupot/models/projects/project.dart';
import 'package:flutter/material.dart';

class ProjectProvider extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  List<ProjectModel> _projects = [];
  DateTime? _lastFetchTime;

  List<ProjectModel> get projects => _projects;

  Future<Map<String, bool>> fetchProjects(String userId,
      {bool forceRefresh = false}) async {
    if (!forceRefresh &&
        _lastFetchTime != null &&
        DateTime.now().difference(_lastFetchTime!).inHours < 2) {
      return {
        "cached": true,
        "success": true,
      };
    }

    try {
      final projectsFuture = await _db.collection('entry').doc(userId).get();
      final projectsList = EntryProjectModel.fromDoc(projectsFuture);

      final List<ProjectModel> temporaryProjects = [];

      if (projectsList?.projects != null &&
          projectsList!.projects!.isNotEmpty) {
        for (DocumentReference<Map<String, dynamic>> projectRef
            in projectsList.projects!) {
          final projectData = ProjectModel.fromDoc(await projectRef.get());
          temporaryProjects.add(projectData!);
        }
      }

      _projects = temporaryProjects;

      _lastFetchTime = DateTime.now();

      notifyListeners();
      return {
        "cached": false,
        "success": true,
      };
    } catch (e) {
      log(e.toString(),
          name: "Error Fetching Projects",
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
