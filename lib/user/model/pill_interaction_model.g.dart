// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pill_interaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PillInteractionModel _$PillInteractionModelFromJson(
        Map<String, dynamic> json) =>
    PillInteractionModel(
      pillName1: json['pill_name1'] as String,
      pillName2: json['pill_name2'] as String,
      clinicalEffect: (json['clinical_effect'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$PillInteractionModelToJson(
        PillInteractionModel instance) =>
    <String, dynamic>{
      'pill_name1': instance.pillName1,
      'pill_name2': instance.pillName2,
      'clinical_effect': instance.clinicalEffect,
    };
