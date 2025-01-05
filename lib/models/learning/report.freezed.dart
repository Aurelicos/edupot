// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'report.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ReportModel {
  String? get uid => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get quizId => throw _privateConstructorUsedError;
  String get quizName => throw _privateConstructorUsedError;
  int get totalQuestions => throw _privateConstructorUsedError;
  int get correctAnswers => throw _privateConstructorUsedError;
  double get percentage => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  List<bool> get isCorrect => throw _privateConstructorUsedError;

  /// Create a copy of ReportModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReportModelCopyWith<ReportModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReportModelCopyWith<$Res> {
  factory $ReportModelCopyWith(
          ReportModel value, $Res Function(ReportModel) then) =
      _$ReportModelCopyWithImpl<$Res, ReportModel>;
  @useResult
  $Res call(
      {String? uid,
      String userId,
      String quizId,
      String quizName,
      int totalQuestions,
      int correctAnswers,
      double percentage,
      DateTime date,
      List<bool> isCorrect});
}

/// @nodoc
class _$ReportModelCopyWithImpl<$Res, $Val extends ReportModel>
    implements $ReportModelCopyWith<$Res> {
  _$ReportModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReportModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = freezed,
    Object? userId = null,
    Object? quizId = null,
    Object? quizName = null,
    Object? totalQuestions = null,
    Object? correctAnswers = null,
    Object? percentage = null,
    Object? date = null,
    Object? isCorrect = null,
  }) {
    return _then(_value.copyWith(
      uid: freezed == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      quizId: null == quizId
          ? _value.quizId
          : quizId // ignore: cast_nullable_to_non_nullable
              as String,
      quizName: null == quizName
          ? _value.quizName
          : quizName // ignore: cast_nullable_to_non_nullable
              as String,
      totalQuestions: null == totalQuestions
          ? _value.totalQuestions
          : totalQuestions // ignore: cast_nullable_to_non_nullable
              as int,
      correctAnswers: null == correctAnswers
          ? _value.correctAnswers
          : correctAnswers // ignore: cast_nullable_to_non_nullable
              as int,
      percentage: null == percentage
          ? _value.percentage
          : percentage // ignore: cast_nullable_to_non_nullable
              as double,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isCorrect: null == isCorrect
          ? _value.isCorrect
          : isCorrect // ignore: cast_nullable_to_non_nullable
              as List<bool>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReportModelImplCopyWith<$Res>
    implements $ReportModelCopyWith<$Res> {
  factory _$$ReportModelImplCopyWith(
          _$ReportModelImpl value, $Res Function(_$ReportModelImpl) then) =
      __$$ReportModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? uid,
      String userId,
      String quizId,
      String quizName,
      int totalQuestions,
      int correctAnswers,
      double percentage,
      DateTime date,
      List<bool> isCorrect});
}

/// @nodoc
class __$$ReportModelImplCopyWithImpl<$Res>
    extends _$ReportModelCopyWithImpl<$Res, _$ReportModelImpl>
    implements _$$ReportModelImplCopyWith<$Res> {
  __$$ReportModelImplCopyWithImpl(
      _$ReportModelImpl _value, $Res Function(_$ReportModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReportModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = freezed,
    Object? userId = null,
    Object? quizId = null,
    Object? quizName = null,
    Object? totalQuestions = null,
    Object? correctAnswers = null,
    Object? percentage = null,
    Object? date = null,
    Object? isCorrect = null,
  }) {
    return _then(_$ReportModelImpl(
      uid: freezed == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      quizId: null == quizId
          ? _value.quizId
          : quizId // ignore: cast_nullable_to_non_nullable
              as String,
      quizName: null == quizName
          ? _value.quizName
          : quizName // ignore: cast_nullable_to_non_nullable
              as String,
      totalQuestions: null == totalQuestions
          ? _value.totalQuestions
          : totalQuestions // ignore: cast_nullable_to_non_nullable
              as int,
      correctAnswers: null == correctAnswers
          ? _value.correctAnswers
          : correctAnswers // ignore: cast_nullable_to_non_nullable
              as int,
      percentage: null == percentage
          ? _value.percentage
          : percentage // ignore: cast_nullable_to_non_nullable
              as double,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isCorrect: null == isCorrect
          ? _value._isCorrect
          : isCorrect // ignore: cast_nullable_to_non_nullable
              as List<bool>,
    ));
  }
}

/// @nodoc

class _$ReportModelImpl implements _ReportModel {
  const _$ReportModelImpl(
      {this.uid,
      required this.userId,
      required this.quizId,
      required this.quizName,
      required this.totalQuestions,
      required this.correctAnswers,
      required this.percentage,
      required this.date,
      required final List<bool> isCorrect})
      : _isCorrect = isCorrect;

  @override
  final String? uid;
  @override
  final String userId;
  @override
  final String quizId;
  @override
  final String quizName;
  @override
  final int totalQuestions;
  @override
  final int correctAnswers;
  @override
  final double percentage;
  @override
  final DateTime date;
  final List<bool> _isCorrect;
  @override
  List<bool> get isCorrect {
    if (_isCorrect is EqualUnmodifiableListView) return _isCorrect;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_isCorrect);
  }

  @override
  String toString() {
    return 'ReportModel(uid: $uid, userId: $userId, quizId: $quizId, quizName: $quizName, totalQuestions: $totalQuestions, correctAnswers: $correctAnswers, percentage: $percentage, date: $date, isCorrect: $isCorrect)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReportModelImpl &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.quizId, quizId) || other.quizId == quizId) &&
            (identical(other.quizName, quizName) ||
                other.quizName == quizName) &&
            (identical(other.totalQuestions, totalQuestions) ||
                other.totalQuestions == totalQuestions) &&
            (identical(other.correctAnswers, correctAnswers) ||
                other.correctAnswers == correctAnswers) &&
            (identical(other.percentage, percentage) ||
                other.percentage == percentage) &&
            (identical(other.date, date) || other.date == date) &&
            const DeepCollectionEquality()
                .equals(other._isCorrect, _isCorrect));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      uid,
      userId,
      quizId,
      quizName,
      totalQuestions,
      correctAnswers,
      percentage,
      date,
      const DeepCollectionEquality().hash(_isCorrect));

  /// Create a copy of ReportModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReportModelImplCopyWith<_$ReportModelImpl> get copyWith =>
      __$$ReportModelImplCopyWithImpl<_$ReportModelImpl>(this, _$identity);
}

abstract class _ReportModel implements ReportModel {
  const factory _ReportModel(
      {final String? uid,
      required final String userId,
      required final String quizId,
      required final String quizName,
      required final int totalQuestions,
      required final int correctAnswers,
      required final double percentage,
      required final DateTime date,
      required final List<bool> isCorrect}) = _$ReportModelImpl;

  @override
  String? get uid;
  @override
  String get userId;
  @override
  String get quizId;
  @override
  String get quizName;
  @override
  int get totalQuestions;
  @override
  int get correctAnswers;
  @override
  double get percentage;
  @override
  DateTime get date;
  @override
  List<bool> get isCorrect;

  /// Create a copy of ReportModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReportModelImplCopyWith<_$ReportModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
