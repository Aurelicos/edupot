// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      uid: json['uid'] as String?,
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      provider: json['provider'] as String,
      createdAt: json['createdAt'],
      enabled: json['enabled'] as bool,
      displayName: json['displayName'] as String?,
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'provider': instance.provider,
      'createdAt': instance.createdAt,
      'enabled': instance.enabled,
      'displayName': instance.displayName,
    };
