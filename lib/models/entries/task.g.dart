// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TaskModelImpl _$$TaskModelImplFromJson(Map<String, dynamic> json) =>
    _$TaskModelImpl(
      id: json['id'] as String?,
      assignedProject: json['assignedProject'],
      title: json['title'] as String,
      description: json['description'] as String,
      finalDate: DateTime.parse(json['finalDate'] as String),
    );

Map<String, dynamic> _$$TaskModelImplToJson(_$TaskModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'assignedProject': instance.assignedProject,
      'title': instance.title,
      'description': instance.description,
      'finalDate': instance.finalDate.toIso8601String(),
    };
