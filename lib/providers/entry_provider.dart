import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EntryProvider extends ChangeNotifier {
  final _db = FirebaseFirestore.instance;
}
