// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarm_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlarmGetModel _$AlarmGetModelFromJson(Map<String, dynamic> json) =>
    AlarmGetModel(
      id: json['id'] as int,
      scheduledTime: json['scheduled_time'] as String,
      patient: json['patient'] as int,
      pill: json['pill'] as int,
    );

Map<String, dynamic> _$AlarmGetModelToJson(AlarmGetModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'scheduled_time': instance.scheduledTime,
      'patient': instance.patient,
      'pill': instance.pill,
    };
