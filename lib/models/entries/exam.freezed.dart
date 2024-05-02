// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exam.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ExamModel {
  String? get id => throw _privateConstructorUsedError;
  int? get priority => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  DateTime get finalDate => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ExamModelCopyWith<ExamModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExamModelCopyWith<$Res> {
  factory $ExamModelCopyWith(ExamModel value, $Res Function(ExamModel) then) =
      _$ExamModelCopyWithImpl<$Res, ExamModel>;
  @useResult
  $Res call(
      {String? id,
      int? priority,
      String title,
      String description,
      DateTime finalDate});
}

/// @nodoc
class _$ExamModelCopyWithImpl<$Res, $Val extends ExamModel>
    implements $ExamModelCopyWith<$Res> {
  _$ExamModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? priority = freezed,
    Object? title = null,
    Object? description = null,
    Object? finalDate = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      priority: freezed == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as int?,
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
abstract class _$$ExamModelImplCopyWith<$Res>
    implements $ExamModelCopyWith<$Res> {
  factory _$$ExamModelImplCopyWith(
          _$ExamModelImpl value, $Res Function(_$ExamModelImpl) then) =
      __$$ExamModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      int? priority,
      String title,
      String description,
      DateTime finalDate});
}

/// @nodoc
class __$$ExamModelImplCopyWithImpl<$Res>
    extends _$ExamModelCopyWithImpl<$Res, _$ExamModelImpl>
    implements _$$ExamModelImplCopyWith<$Res> {
  __$$ExamModelImplCopyWithImpl(
      _$ExamModelImpl _value, $Res Function(_$ExamModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? priority = freezed,
    Object? title = null,
    Object? description = null,
    Object? finalDate = null,
  }) {
    return _then(_$ExamModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      priority: freezed == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as int?,
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

class _$ExamModelImpl with DiagnosticableTreeMixin implements _ExamModel {
  const _$ExamModelImpl(
      {this.id,
      this.priority,
      required this.title,
      required this.description,
      required this.finalDate});

  @override
  final String? id;
  @override
  final int? priority;
  @override
  final String title;
  @override
  final String description;
  @override
  final DateTime finalDate;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ExamModel(id: $id, priority: $priority, title: $title, description: $description, finalDate: $finalDate)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ExamModel'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('priority', priority))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('finalDate', finalDate));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExamModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.finalDate, finalDate) ||
                other.finalDate == finalDate));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, priority, title, description, finalDate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ExamModelImplCopyWith<_$ExamModelImpl> get copyWith =>
      __$$ExamModelImplCopyWithImpl<_$ExamModelImpl>(this, _$identity);
}

abstract class _ExamModel implements ExamModel {
  const factory _ExamModel(
      {final String? id,
      final int? priority,
      required final String title,
      required final String description,
      required final DateTime finalDate}) = _$ExamModelImpl;

  @override
  String? get id;
  @override
  int? get priority;
  @override
  String get title;
  @override
  String get description;
  @override
  DateTime get finalDate;
  @override
  @JsonKey(ignore: true)
  _$$ExamModelImplCopyWith<_$ExamModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
