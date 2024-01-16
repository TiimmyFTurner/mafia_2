// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RoleImpl _$$RoleImplFromJson(Map<String, dynamic> json) => _$RoleImpl(
      name: json['name'] as String,
      type: json['type'] as String,
      job: json['job'] as String,
      order: json['order'] as int,
    );

Map<String, dynamic> _$$RoleImplToJson(_$RoleImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': instance.type,
      'job': instance.job,
      'order': instance.order,
    };
