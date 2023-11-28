import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:yakmoya/pill/pill_picture/model/model_with_id.dart';

part 'alarm_model.g.dart';

@JsonSerializable()
class AlarmGetModel implements IModelWithId {
  @override
  int id;
  @JsonKey(name: 'scheduled_time')
  String scheduledTime;
  int patient;
  int pill;

  AlarmGetModel({
    required this.id,
    required this.scheduledTime,
    required this.patient,
    required this.pill,
  });

  factory AlarmGetModel.fromJson(Map<String, dynamic> json) =>
      _$AlarmGetModelFromJson(json);

  Map<String, dynamic> toJson() => _$AlarmGetModelToJson(this);
}
