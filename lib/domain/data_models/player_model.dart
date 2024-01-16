import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mafia_2/domain/data_models/role_model.dart';

part 'player_model.freezed.dart';

part 'player_model.g.dart';

@unfreezed
class Player with _$Player {
  factory Player({
    required String name,
    required Role role,
    required String status,
  }) = _Player;

  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);
}
