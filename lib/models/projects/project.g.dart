// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProjectModelImpl _$$ProjectModelImplFromJson(Map<String, dynamic> json) =>
    _$ProjectModelImpl(
      id: json['id'] as String?,
      name: json['name'] as String,
      description: json['description'] as String,
      finalDate: DateTime.parse(json['finalDate'] as String),
      finished: json['finished'] as int,
      iconTitle: json['iconTitle'] as String,
      tasks: json['tasks'] as List<dynamic>,
    );

Map<String, dynamic> _$$ProjectModelImplToJson(_$ProjectModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'finalDate': instance.finalDate.toIso8601String(),
      'finished': instance.finished,
      'iconTitle': instance.iconTitle,
      'tasks': instance.tasks,
    };
