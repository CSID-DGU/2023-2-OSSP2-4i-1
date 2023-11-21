// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pill_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PillDetailModel _$PillDetailModelFromJson(Map<String, dynamic> json) =>
    PillDetailModel(
      id: json['id'] as int,
      idx: json['idx'] as String,
      drugName: json['drug_name'] as String,
      pillEffect: json['pill_effect'] as String,
      pillAmount: json['pill_amount'] as String,
      pillDetail: json['pill_detail'] as String,
      pillMethod: json['pill_method'] as String,
      pillFood: json['pill_food'] as String,
      interX: json['inter_x'] as int,
      pillInter: json['pill_inter'] as String,
    );

Map<String, dynamic> _$PillDetailModelToJson(PillDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'idx': instance.idx,
      'drug_name': instance.drugName,
      'pill_effect': instance.pillEffect,
      'pill_amount': instance.pillAmount,
      'pill_detail': instance.pillDetail,
      'pill_method': instance.pillMethod,
      'pill_food': instance.pillFood,
      'inter_x': instance.interX,
      'pill_inter': instance.pillInter,
    };
