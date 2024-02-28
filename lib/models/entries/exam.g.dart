// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exam.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ExamModelImpl _$$ExamModelImplFromJson(Map<String, dynamic> json) =>
    _$ExamModelImpl(
      id: json['id'] as String?,
      priority: json['priority'] as int?,
      title: json['title'] as String,
      description: json['description'] as String,
      finalDate: DateTime.parse(json['finalDate'] as String),
    );

Map<String, dynamic> _$$ExamModelImplToJson(_$ExamModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'priority': instance.priority,
      'title': instance.title,
      'description': instance.description,
      'finalDate': instance.finalDate.toIso8601String(),
    };
