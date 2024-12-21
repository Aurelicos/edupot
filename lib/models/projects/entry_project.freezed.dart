// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'entry_project.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$EntryProjectModel {
  List<DocumentReference<Map<String, dynamic>>>? get projects =>
      throw _privateConstructorUsedError;

  /// Create a copy of EntryProjectModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EntryProjectModelCopyWith<EntryProjectModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EntryProjectModelCopyWith<$Res> {
  factory $EntryProjectModelCopyWith(
          EntryProjectModel value, $Res Function(EntryProjectModel) then) =
      _$EntryProjectModelCopyWithImpl<$Res, EntryProjectModel>;
  @useResult
  $Res call({List<DocumentReference<Map<String, dynamic>>>? projects});
}

/// @nodoc
class _$EntryProjectModelCopyWithImpl<$Res, $Val extends EntryProjectModel>
    implements $EntryProjectModelCopyWith<$Res> {
  _$EntryProjectModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EntryProjectModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? projects = freezed,
  }) {
    return _then(_value.copyWith(
      projects: freezed == projects
          ? _value.projects
          : projects // ignore: cast_nullable_to_non_nullable
              as List<DocumentReference<Map<String, dynamic>>>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EntryProjectModelImplCopyWith<$Res>
    implements $EntryProjectModelCopyWith<$Res> {
  factory _$$EntryProjectModelImplCopyWith(_$EntryProjectModelImpl value,
          $Res Function(_$EntryProjectModelImpl) then) =
      __$$EntryProjectModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<DocumentReference<Map<String, dynamic>>>? projects});
}

/// @nodoc
class __$$EntryProjectModelImplCopyWithImpl<$Res>
    extends _$EntryProjectModelCopyWithImpl<$Res, _$EntryProjectModelImpl>
    implements _$$EntryProjectModelImplCopyWith<$Res> {
  __$$EntryProjectModelImplCopyWithImpl(_$EntryProjectModelImpl _value,
      $Res Function(_$EntryProjectModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of EntryProjectModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? projects = freezed,
  }) {
    return _then(_$EntryProjectModelImpl(
      projects: freezed == projects
          ? _value._projects
          : projects // ignore: cast_nullable_to_non_nullable
              as List<DocumentReference<Map<String, dynamic>>>?,
    ));
  }
}

/// @nodoc

class _$EntryProjectModelImpl
    with DiagnosticableTreeMixin
    implements _EntryProjectModel {
  const _$EntryProjectModelImpl(
      {required final List<DocumentReference<Map<String, dynamic>>>? projects})
      : _projects = projects;

  final List<DocumentReference<Map<String, dynamic>>>? _projects;
  @override
  List<DocumentReference<Map<String, dynamic>>>? get projects {
    final value = _projects;
    if (value == null) return null;
    if (_projects is EqualUnmodifiableListView) return _projects;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'EntryProjectModel(projects: $projects)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'EntryProjectModel'))
      ..add(DiagnosticsProperty('projects', projects));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EntryProjectModelImpl &&
            const DeepCollectionEquality().equals(other._projects, _projects));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_projects));

  /// Create a copy of EntryProjectModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EntryProjectModelImplCopyWith<_$EntryProjectModelImpl> get copyWith =>
      __$$EntryProjectModelImplCopyWithImpl<_$EntryProjectModelImpl>(
          this, _$identity);
}

abstract class _EntryProjectModel implements EntryProjectModel {
  const factory _EntryProjectModel(
      {required final List<DocumentReference<Map<String, dynamic>>>?
          projects}) = _$EntryProjectModelImpl;

  @override
  List<DocumentReference<Map<String, dynamic>>>? get projects;

  /// Create a copy of EntryProjectModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EntryProjectModelImplCopyWith<_$EntryProjectModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
