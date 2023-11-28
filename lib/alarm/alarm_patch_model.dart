import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'alarm_patch_model.g.dart';

@JsonSerializable()
class AlarmPatchModel {
  int id;
  String scheduledTime;
  int patient;
  int pill;

  AlarmPatchModel({
    required this.id,
    required this.scheduledTime,
    required this.patient,
    required this.pill,
  });

  factory AlarmPatchModel.fromJson(Map<String, dynamic> json) =>
      _$AlarmPatchModelFromJson(json);

  Map<String, dynamic> toJson() => _$AlarmPatchModelToJson(this);
}
