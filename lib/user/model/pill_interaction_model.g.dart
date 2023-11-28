// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pill_interaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PillInteractionModel _$PillInteractionModelFromJson(
        Map<String, dynamic> json) =>
    PillInteractionModel(
      pillName1: json['pillName1'] as String,
      pillName2: json['pillName2'] as String,
      clinicalEffect: (json['clinicalEffect'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$PillInteractionModelToJson(
        PillInteractionModel instance) =>
    <String, dynamic>{
      'pillName1': instance.pillName1,
      'pillName2': instance.pillName2,
      'clinicalEffect': instance.clinicalEffect,
    };
