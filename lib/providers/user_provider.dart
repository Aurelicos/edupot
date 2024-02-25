import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edupot/models/user.dart';
import 'package:edupot/services/auth.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  final _db = FirebaseFirestore.instance;
  final _auth = AuthService();

  User? _user;
  String? _email;
  String? _firstName;
  String? _lastName;
  String? _displayName;

  User? get user => _user;

  set email(String? email) => _email = email;

  set firstName(String? name) => _firstName = name;

  set lastName(String? name) => _lastName = name;

  set displayName(String? name) => _displayName = name;

  Future<bool> updateUserData(dynamic value) async {
    try {
      await _db.collection('users').doc(_user!.uid).update(value);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> _createUser({required String uid}) async {
    try {
      _user = User(
        uid: uid,
        email: _email ?? '',
        firstName: _firstName ?? '',
        lastName: _lastName ?? '',
        provider: _auth.currentUser?.providerData[0].providerId ?? '',
        createdAt: DateTime.now(),
        enabled: true,
        displayName: _displayName ?? '',
      );

      await _db.collection('users').doc(uid).set(User.toDoc(user!));

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<dynamic> _fetchUserData({required String uid}) async {
    try {
      final doc = await _db.collection('users').doc(uid).get();
      if (doc.exists) {
        _user = User.fromDoc(doc);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<Map<String, bool>> handleAuth({required String uid}) async {
    try {
      if (await _fetchUserData(uid: uid)) {
        if (_user!.enabled == false) {
          await _auth.signOut();
          return {
            'success': false,
            'data': false,
          };
        }

        if (_user!.provider != _auth.currentUser?.providerData[0].providerId) {
          updateUserData(
            {
              'provider': _auth.currentUser?.providerData[0].providerId,
            },
          );
        }

        return {
          'success': true,
          'data': true,
        };
      } else {
        if (_auth.currentUser?.providerData[0].providerId != 'password') {
          _email = _auth.currentUser?.email;
          _displayName = _auth.currentUser?.displayName;
        }

        return {
          'success': await _createUser(uid: uid),
          'data': false,
        };
      }
    } catch (e) {
      return {
        'success': false,
        'data': false,
      };
    }
  }

  Future<void> clearUser() async {
    _user = null;
    _email = null;
    _firstName = null;
    _lastName = null;
    _displayName = null;
  }
}
