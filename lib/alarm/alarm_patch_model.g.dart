// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarm_patch_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlarmPatchModel _$AlarmPatchModelFromJson(Map<String, dynamic> json) =>
    AlarmPatchModel(
      id: json['id'] as int,
      scheduledTime: json['scheduledTime'] as String,
      patient: json['patient'] as int,
      pill: json['pill'] as int,
    );

Map<String, dynamic> _$AlarmPatchModelToJson(AlarmPatchModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'scheduledTime': instance.scheduledTime,
      'patient': instance.patient,
      'pill': instance.pill,
    };
