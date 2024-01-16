import 'package:freezed_annotation/freezed_annotation.dart';

part 'role_model.freezed.dart';

part 'role_model.g.dart';

@freezed
class Role with _$Role {
  factory Role({
    required String name,
    required String type,
    required String job,
    required int order,
  }) = _Role;

  factory Role.fromJson(Map<String, dynamic> json) => _$RoleFromJson(json);
}
