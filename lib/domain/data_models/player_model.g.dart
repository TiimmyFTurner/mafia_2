// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PlayerImpl _$$PlayerImplFromJson(Map<String, dynamic> json) => _$PlayerImpl(
      name: json['name'] as String,
      role: Role.fromJson(json['role'] as Map<String, dynamic>),
      status: json['status'] as String,
    );

Map<String, dynamic> _$$PlayerImplToJson(_$PlayerImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'role': instance.role,
      'status': instance.status,
    };
