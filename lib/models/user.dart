import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'user.freezed.dart';

part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    String? uid,
    required String email,
    required String firstName,
    required String lastName,
    required String provider,
    required dynamic createdAt,
    required bool enabled,
    String? displayName,
  }) = _User;

  static User? fromDoc(DocumentSnapshot document) {
    final data = document.data() as Map<String, dynamic>;

    return User(
      uid: document.id,
      email: data["email"],
      firstName: data["firstName"],
      lastName: data["lastName"],
      provider: data["provider"],
      createdAt: data["createdAt"],
      enabled: data["enabled"],
      displayName: data["displayName"] ?? "",
    );
  }

  static Map<String, dynamic> toDoc(User user) {
    return {
      "email": user.email,
      "firstName": user.firstName,
      "lastName": user.lastName,
      "provider": user.provider,
      "createdAt": user.createdAt,
      "enabled": user.enabled,
      "displayName": user.displayName ?? "",
    };
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}