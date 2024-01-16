import 'package:freezed_annotation/freezed_annotation.dart';

part 'last_move_model.freezed.dart';

part 'last_move_model.g.dart';

@freezed
class LastMove with _$LastMove {
  factory LastMove({
    required String name,
    required String description,
    required String color,
  }) = _LastMove;

  factory LastMove.fromJson(Map<String, dynamic> json) =>
      _$LastMoveFromJson(json);
}
