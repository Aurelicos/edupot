// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TaskModel {
  String? get id => throw _privateConstructorUsedError;
  DocumentReference<Object?>? get assignedProject =>
      throw _privateConstructorUsedError;
  bool? get done => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  DateTime get finalDate => throw _privateConstructorUsedError;

  /// Create a copy of TaskModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TaskModelCopyWith<TaskModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskModelCopyWith<$Res> {
  factory $TaskModelCopyWith(TaskModel value, $Res Function(TaskModel) then) =
      _$TaskModelCopyWithImpl<$Res, TaskModel>;
  @useResult
  $Res call(
      {String? id,
      DocumentReference<Object?>? assignedProject,
      bool? done,
      String title,
      String description,
      DateTime finalDate});
}

/// @nodoc
class _$TaskModelCopyWithImpl<$Res, $Val extends TaskModel>
    implements $TaskModelCopyWith<$Res> {
  _$TaskModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TaskModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? assignedProject = freezed,
    Object? done = freezed,
    Object? title = null,
    Object? description = null,
    Object? finalDate = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      assignedProject: freezed == assignedProject
          ? _value.assignedProject
          : assignedProject // ignore: cast_nullable_to_non_nullable
              as DocumentReference<Object?>?,
      done: freezed == done
          ? _value.done
          : done // ignore: cast_nullable_to_non_nullable
              as bool?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      finalDate: null == finalDate
          ? _value.finalDate
          : finalDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TaskModelImplCopyWith<$Res>
    implements $TaskModelCopyWith<$Res> {
  factory _$$TaskModelImplCopyWith(
          _$TaskModelImpl value, $Res Function(_$TaskModelImpl) then) =
      __$$TaskModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      DocumentReference<Object?>? assignedProject,
      bool? done,
      String title,
      String description,
      DateTime finalDate});
}

/// @nodoc
class __$$TaskModelImplCopyWithImpl<$Res>
    extends _$TaskModelCopyWithImpl<$Res, _$TaskModelImpl>
    implements _$$TaskModelImplCopyWith<$Res> {
  __$$TaskModelImplCopyWithImpl(
      _$TaskModelImpl _value, $Res Function(_$TaskModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of TaskModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? assignedProject = freezed,
    Object? done = freezed,
    Object? title = null,
    Object? description = null,
    Object? finalDate = null,
  }) {
    return _then(_$TaskModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      assignedProject: freezed == assignedProject
          ? _value.assignedProject
          : assignedProject // ignore: cast_nullable_to_non_nullable
              as DocumentReference<Object?>?,
      done: freezed == done
          ? _value.done
          : done // ignore: cast_nullable_to_non_nullable
              as bool?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      finalDate: null == finalDate
          ? _value.finalDate
          : finalDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$TaskModelImpl with DiagnosticableTreeMixin implements _TaskModel {
  const _$TaskModelImpl(
      {this.id,
      this.assignedProject,
      this.done,
      required this.title,
      required this.description,
      required this.finalDate});

  @override
  final String? id;
  @override
  final DocumentReference<Object?>? assignedProject;
  @override
  final bool? done;
  @override
  final String title;
  @override
  final String description;
  @override
  final DateTime finalDate;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TaskModel(id: $id, assignedProject: $assignedProject, done: $done, title: $title, description: $description, finalDate: $finalDate)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TaskModel'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('assignedProject', assignedProject))
      ..add(DiagnosticsProperty('done', done))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('finalDate', finalDate));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.assignedProject, assignedProject) ||
                other.assignedProject == assignedProject) &&
            (identical(other.done, done) || other.done == done) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.finalDate, finalDate) ||
                other.finalDate == finalDate));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, id, assignedProject, done, title, description, finalDate);

  /// Create a copy of TaskModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskModelImplCopyWith<_$TaskModelImpl> get copyWith =>
      __$$TaskModelImplCopyWithImpl<_$TaskModelImpl>(this, _$identity);
}

abstract class _TaskModel implements TaskModel {
  const factory _TaskModel(
      {final String? id,
      final DocumentReference<Object?>? assignedProject,
      final bool? done,
      required final String title,
      required final String description,
      required final DateTime finalDate}) = _$TaskModelImpl;

  @override
  String? get id;
  @override
  DocumentReference<Object?>? get assignedProject;
  @override
  bool? get done;
  @override
  String get title;
  @override
  String get description;
  @override
  DateTime get finalDate;

  /// Create a copy of TaskModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaskModelImplCopyWith<_$TaskModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
