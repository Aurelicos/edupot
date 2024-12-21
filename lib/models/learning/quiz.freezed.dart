// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quiz.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$QuizModel {
  String? get uid => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  bool get isPublic => throw _privateConstructorUsedError;
  List<String> get questions => throw _privateConstructorUsedError;
  List<String> get answerTypes => throw _privateConstructorUsedError;
  List<List<String>> get answers => throw _privateConstructorUsedError;
  List<List<String>> get correctAnswers => throw _privateConstructorUsedError;
  List<int> get times => throw _privateConstructorUsedError;

  /// Create a copy of QuizModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuizModelCopyWith<QuizModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuizModelCopyWith<$Res> {
  factory $QuizModelCopyWith(QuizModel value, $Res Function(QuizModel) then) =
      _$QuizModelCopyWithImpl<$Res, QuizModel>;
  @useResult
  $Res call(
      {String? uid,
      String title,
      bool isPublic,
      List<String> questions,
      List<String> answerTypes,
      List<List<String>> answers,
      List<List<String>> correctAnswers,
      List<int> times});
}

/// @nodoc
class _$QuizModelCopyWithImpl<$Res, $Val extends QuizModel>
    implements $QuizModelCopyWith<$Res> {
  _$QuizModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuizModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = freezed,
    Object? title = null,
    Object? isPublic = null,
    Object? questions = null,
    Object? answerTypes = null,
    Object? answers = null,
    Object? correctAnswers = null,
    Object? times = null,
  }) {
    return _then(_value.copyWith(
      uid: freezed == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      isPublic: null == isPublic
          ? _value.isPublic
          : isPublic // ignore: cast_nullable_to_non_nullable
              as bool,
      questions: null == questions
          ? _value.questions
          : questions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      answerTypes: null == answerTypes
          ? _value.answerTypes
          : answerTypes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      answers: null == answers
          ? _value.answers
          : answers // ignore: cast_nullable_to_non_nullable
              as List<List<String>>,
      correctAnswers: null == correctAnswers
          ? _value.correctAnswers
          : correctAnswers // ignore: cast_nullable_to_non_nullable
              as List<List<String>>,
      times: null == times
          ? _value.times
          : times // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QuizModelImplCopyWith<$Res>
    implements $QuizModelCopyWith<$Res> {
  factory _$$QuizModelImplCopyWith(
          _$QuizModelImpl value, $Res Function(_$QuizModelImpl) then) =
      __$$QuizModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? uid,
      String title,
      bool isPublic,
      List<String> questions,
      List<String> answerTypes,
      List<List<String>> answers,
      List<List<String>> correctAnswers,
      List<int> times});
}

/// @nodoc
class __$$QuizModelImplCopyWithImpl<$Res>
    extends _$QuizModelCopyWithImpl<$Res, _$QuizModelImpl>
    implements _$$QuizModelImplCopyWith<$Res> {
  __$$QuizModelImplCopyWithImpl(
      _$QuizModelImpl _value, $Res Function(_$QuizModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of QuizModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = freezed,
    Object? title = null,
    Object? isPublic = null,
    Object? questions = null,
    Object? answerTypes = null,
    Object? answers = null,
    Object? correctAnswers = null,
    Object? times = null,
  }) {
    return _then(_$QuizModelImpl(
      uid: freezed == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      isPublic: null == isPublic
          ? _value.isPublic
          : isPublic // ignore: cast_nullable_to_non_nullable
              as bool,
      questions: null == questions
          ? _value._questions
          : questions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      answerTypes: null == answerTypes
          ? _value._answerTypes
          : answerTypes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      answers: null == answers
          ? _value._answers
          : answers // ignore: cast_nullable_to_non_nullable
              as List<List<String>>,
      correctAnswers: null == correctAnswers
          ? _value._correctAnswers
          : correctAnswers // ignore: cast_nullable_to_non_nullable
              as List<List<String>>,
      times: null == times
          ? _value._times
          : times // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

/// @nodoc

class _$QuizModelImpl with DiagnosticableTreeMixin implements _QuizModel {
  const _$QuizModelImpl(
      {this.uid,
      required this.title,
      required this.isPublic,
      required final List<String> questions,
      required final List<String> answerTypes,
      required final List<List<String>> answers,
      required final List<List<String>> correctAnswers,
      required final List<int> times})
      : _questions = questions,
        _answerTypes = answerTypes,
        _answers = answers,
        _correctAnswers = correctAnswers,
        _times = times;

  @override
  final String? uid;
  @override
  final String title;
  @override
  final bool isPublic;
  final List<String> _questions;
  @override
  List<String> get questions {
    if (_questions is EqualUnmodifiableListView) return _questions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_questions);
  }

  final List<String> _answerTypes;
  @override
  List<String> get answerTypes {
    if (_answerTypes is EqualUnmodifiableListView) return _answerTypes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_answerTypes);
  }

  final List<List<String>> _answers;
  @override
  List<List<String>> get answers {
    if (_answers is EqualUnmodifiableListView) return _answers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_answers);
  }

  final List<List<String>> _correctAnswers;
  @override
  List<List<String>> get correctAnswers {
    if (_correctAnswers is EqualUnmodifiableListView) return _correctAnswers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_correctAnswers);
  }

  final List<int> _times;
  @override
  List<int> get times {
    if (_times is EqualUnmodifiableListView) return _times;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_times);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'QuizModel(uid: $uid, title: $title, isPublic: $isPublic, questions: $questions, answerTypes: $answerTypes, answers: $answers, correctAnswers: $correctAnswers, times: $times)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'QuizModel'))
      ..add(DiagnosticsProperty('uid', uid))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('isPublic', isPublic))
      ..add(DiagnosticsProperty('questions', questions))
      ..add(DiagnosticsProperty('answerTypes', answerTypes))
      ..add(DiagnosticsProperty('answers', answers))
      ..add(DiagnosticsProperty('correctAnswers', correctAnswers))
      ..add(DiagnosticsProperty('times', times));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuizModelImpl &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.isPublic, isPublic) ||
                other.isPublic == isPublic) &&
            const DeepCollectionEquality()
                .equals(other._questions, _questions) &&
            const DeepCollectionEquality()
                .equals(other._answerTypes, _answerTypes) &&
            const DeepCollectionEquality().equals(other._answers, _answers) &&
            const DeepCollectionEquality()
                .equals(other._correctAnswers, _correctAnswers) &&
            const DeepCollectionEquality().equals(other._times, _times));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      uid,
      title,
      isPublic,
      const DeepCollectionEquality().hash(_questions),
      const DeepCollectionEquality().hash(_answerTypes),
      const DeepCollectionEquality().hash(_answers),
      const DeepCollectionEquality().hash(_correctAnswers),
      const DeepCollectionEquality().hash(_times));

  /// Create a copy of QuizModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuizModelImplCopyWith<_$QuizModelImpl> get copyWith =>
      __$$QuizModelImplCopyWithImpl<_$QuizModelImpl>(this, _$identity);
}

abstract class _QuizModel implements QuizModel {
  const factory _QuizModel(
      {final String? uid,
      required final String title,
      required final bool isPublic,
      required final List<String> questions,
      required final List<String> answerTypes,
      required final List<List<String>> answers,
      required final List<List<String>> correctAnswers,
      required final List<int> times}) = _$QuizModelImpl;

  @override
  String? get uid;
  @override
  String get title;
  @override
  bool get isPublic;
  @override
  List<String> get questions;
  @override
  List<String> get answerTypes;
  @override
  List<List<String>> get answers;
  @override
  List<List<String>> get correctAnswers;
  @override
  List<int> get times;

  /// Create a copy of QuizModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuizModelImplCopyWith<_$QuizModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
