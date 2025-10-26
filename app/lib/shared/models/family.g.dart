// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'family.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Family _$FamilyFromJson(Map<String, dynamic> json) => Family(
  id: json['id'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
  name: json['name'] as String,
  familyCode: json['family_code'] as String,
);

Map<String, dynamic> _$FamilyToJson(Family instance) => <String, dynamic>{
  'id': instance.id,
  'created_at': instance.createdAt.toIso8601String(),
  'name': instance.name,
  'family_code': instance.familyCode,
};
