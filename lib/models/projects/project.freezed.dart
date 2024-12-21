// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'project.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ProjectModel {
  String? get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  DateTime get finalDate => throw _privateConstructorUsedError;
  int get finished => throw _privateConstructorUsedError;
  String get iconTitle => throw _privateConstructorUsedError;
  List<DocumentReference<Object?>> get tasks =>
      throw _privateConstructorUsedError;

  /// Create a copy of ProjectModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProjectModelCopyWith<ProjectModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectModelCopyWith<$Res> {
  factory $ProjectModelCopyWith(
          ProjectModel value, $Res Function(ProjectModel) then) =
      _$ProjectModelCopyWithImpl<$Res, ProjectModel>;
  @useResult
  $Res call(
      {String? id,
      String name,
      String description,
      DateTime finalDate,
      int finished,
      String iconTitle,
      List<DocumentReference<Object?>> tasks});
}

/// @nodoc
class _$ProjectModelCopyWithImpl<$Res, $Val extends ProjectModel>
    implements $ProjectModelCopyWith<$Res> {
  _$ProjectModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProjectModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? description = null,
    Object? finalDate = null,
    Object? finished = null,
    Object? iconTitle = null,
    Object? tasks = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      finalDate: null == finalDate
          ? _value.finalDate
          : finalDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      finished: null == finished
          ? _value.finished
          : finished // ignore: cast_nullable_to_non_nullable
              as int,
      iconTitle: null == iconTitle
          ? _value.iconTitle
          : iconTitle // ignore: cast_nullable_to_non_nullable
              as String,
      tasks: null == tasks
          ? _value.tasks
          : tasks // ignore: cast_nullable_to_non_nullable
              as List<DocumentReference<Object?>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProjectModelImplCopyWith<$Res>
    implements $ProjectModelCopyWith<$Res> {
  factory _$$ProjectModelImplCopyWith(
          _$ProjectModelImpl value, $Res Function(_$ProjectModelImpl) then) =
      __$$ProjectModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String name,
      String description,
      DateTime finalDate,
      int finished,
      String iconTitle,
      List<DocumentReference<Object?>> tasks});
}

/// @nodoc
class __$$ProjectModelImplCopyWithImpl<$Res>
    extends _$ProjectModelCopyWithImpl<$Res, _$ProjectModelImpl>
    implements _$$ProjectModelImplCopyWith<$Res> {
  __$$ProjectModelImplCopyWithImpl(
      _$ProjectModelImpl _value, $Res Function(_$ProjectModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProjectModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? description = null,
    Object? finalDate = null,
    Object? finished = null,
    Object? iconTitle = null,
    Object? tasks = null,
  }) {
    return _then(_$ProjectModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      finalDate: null == finalDate
          ? _value.finalDate
          : finalDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      finished: null == finished
          ? _value.finished
          : finished // ignore: cast_nullable_to_non_nullable
              as int,
      iconTitle: null == iconTitle
          ? _value.iconTitle
          : iconTitle // ignore: cast_nullable_to_non_nullable
              as String,
      tasks: null == tasks
          ? _value._tasks
          : tasks // ignore: cast_nullable_to_non_nullable
              as List<DocumentReference<Object?>>,
    ));
  }
}

/// @nodoc

class _$ProjectModelImpl with DiagnosticableTreeMixin implements _ProjectModel {
  const _$ProjectModelImpl(
      {this.id,
      required this.name,
      required this.description,
      required this.finalDate,
      required this.finished,
      required this.iconTitle,
      required final List<DocumentReference<Object?>> tasks})
      : _tasks = tasks;

  @override
  final String? id;
  @override
  final String name;
  @override
  final String description;
  @override
  final DateTime finalDate;
  @override
  final int finished;
  @override
  final String iconTitle;
  final List<DocumentReference<Object?>> _tasks;
  @override
  List<DocumentReference<Object?>> get tasks {
    if (_tasks is EqualUnmodifiableListView) return _tasks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tasks);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ProjectModel(id: $id, name: $name, description: $description, finalDate: $finalDate, finished: $finished, iconTitle: $iconTitle, tasks: $tasks)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ProjectModel'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('finalDate', finalDate))
      ..add(DiagnosticsProperty('finished', finished))
      ..add(DiagnosticsProperty('iconTitle', iconTitle))
      ..add(DiagnosticsProperty('tasks', tasks));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProjectModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.finalDate, finalDate) ||
                other.finalDate == finalDate) &&
            (identical(other.finished, finished) ||
                other.finished == finished) &&
            (identical(other.iconTitle, iconTitle) ||
                other.iconTitle == iconTitle) &&
            const DeepCollectionEquality().equals(other._tasks, _tasks));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name, description, finalDate,
      finished, iconTitle, const DeepCollectionEquality().hash(_tasks));

  /// Create a copy of ProjectModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProjectModelImplCopyWith<_$ProjectModelImpl> get copyWith =>
      __$$ProjectModelImplCopyWithImpl<_$ProjectModelImpl>(this, _$identity);
}

abstract class _ProjectModel implements ProjectModel {
  const factory _ProjectModel(
          {final String? id,
          required final String name,
          required final String description,
          required final DateTime finalDate,
          required final int finished,
          required final String iconTitle,
          required final List<DocumentReference<Object?>> tasks}) =
      _$ProjectModelImpl;

  @override
  String? get id;
  @override
  String get name;
  @override
  String get description;
  @override
  DateTime get finalDate;
  @override
  int get finished;
  @override
  String get iconTitle;
  @override
  List<DocumentReference<Object?>> get tasks;

  /// Create a copy of ProjectModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProjectModelImplCopyWith<_$ProjectModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
