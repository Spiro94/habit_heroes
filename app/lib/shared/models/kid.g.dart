// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kid.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Kid _$KidFromJson(Map<String, dynamic> json) => Kid(
  id: json['id'] as String,
  parentId: json['parent_id'] as String,
  name: json['name'] as String,
  avatarUrl: json['avatar_url'] as String?,
  color: json['color'] as String?,
  orderIndex: (json['order_index'] as num?)?.toInt(),
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$KidToJson(Kid instance) => <String, dynamic>{
  'id': instance.id,
  'parent_id': instance.parentId,
  'name': instance.name,
  'avatar_url': instance.avatarUrl,
  'color': instance.color,
  'order_index': instance.orderIndex,
  'created_at': instance.createdAt?.toIso8601String(),
};
