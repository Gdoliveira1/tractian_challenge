// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssetModel _$AssetModelFromJson(Map<String, dynamic> json) => AssetModel(
      id: json['id'] as String,
      name: json['name'] as String,
      parentId: json['parentId'] as String?,
      locationId: json['locationId'] as String?,
      sensorType: json['sensorType'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$AssetModelToJson(AssetModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'parentId': instance.parentId,
      'locationId': instance.locationId,
      'sensorType': instance.sensorType,
      'status': instance.status,
    };
