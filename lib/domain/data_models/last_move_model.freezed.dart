// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'last_move_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

LastMove _$LastMoveFromJson(Map<String, dynamic> json) {
  return _LastMove.fromJson(json);
}

/// @nodoc
mixin _$LastMove {
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get color => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LastMoveCopyWith<LastMove> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LastMoveCopyWith<$Res> {
  factory $LastMoveCopyWith(LastMove value, $Res Function(LastMove) then) =
      _$LastMoveCopyWithImpl<$Res, LastMove>;
  @useResult
  $Res call({String name, String description, String color});
}

/// @nodoc
class _$LastMoveCopyWithImpl<$Res, $Val extends LastMove>
    implements $LastMoveCopyWith<$Res> {
  _$LastMoveCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = null,
    Object? color = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LastMoveImplCopyWith<$Res>
    implements $LastMoveCopyWith<$Res> {
  factory _$$LastMoveImplCopyWith(
          _$LastMoveImpl value, $Res Function(_$LastMoveImpl) then) =
      __$$LastMoveImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String description, String color});
}

/// @nodoc
class __$$LastMoveImplCopyWithImpl<$Res>
    extends _$LastMoveCopyWithImpl<$Res, _$LastMoveImpl>
    implements _$$LastMoveImplCopyWith<$Res> {
  __$$LastMoveImplCopyWithImpl(
      _$LastMoveImpl _value, $Res Function(_$LastMoveImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = null,
    Object? color = null,
  }) {
    return _then(_$LastMoveImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LastMoveImpl implements _LastMove {
  _$LastMoveImpl(
      {required this.name, required this.description, required this.color});

  factory _$LastMoveImpl.fromJson(Map<String, dynamic> json) =>
      _$$LastMoveImplFromJson(json);

  @override
  final String name;
  @override
  final String description;
  @override
  final String color;

  @override
  String toString() {
    return 'LastMove(name: $name, description: $description, color: $color)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LastMoveImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.color, color) || other.color == color));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, description, color);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LastMoveImplCopyWith<_$LastMoveImpl> get copyWith =>
      __$$LastMoveImplCopyWithImpl<_$LastMoveImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LastMoveImplToJson(
      this,
    );
  }
}

abstract class _LastMove implements LastMove {
  factory _LastMove(
      {required final String name,
      required final String description,
      required final String color}) = _$LastMoveImpl;

  factory _LastMove.fromJson(Map<String, dynamic> json) =
      _$LastMoveImpl.fromJson;

  @override
  String get name;
  @override
  String get description;
  @override
  String get color;
  @override
  @JsonKey(ignore: true)
  _$$LastMoveImplCopyWith<_$LastMoveImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
