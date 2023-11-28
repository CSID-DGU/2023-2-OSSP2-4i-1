// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pill_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PillDetailModel _$PillDetailModelFromJson(Map<String, dynamic> json) =>
    PillDetailModel(
      id: json['id'] as int,
      name: json['name'] as String,
      pillEffect: json['pill_effect'] as String,
      pillDetail: json['pill_detail'] as String,
      pillMethod: json['pill_method'] as String,
    );

Map<String, dynamic> _$PillDetailModelToJson(PillDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'pill_effect': instance.pillEffect,
      'pill_detail': instance.pillDetail,
      'pill_method': instance.pillMethod,
    };
