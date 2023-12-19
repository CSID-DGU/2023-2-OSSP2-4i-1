import 'package:json_annotation/json_annotation.dart';

part 'alarm_model.g.dart';


@JsonSerializable()
class AlarmModel{
  final String id;
  final String time;

  AlarmModel({
    required this.id,
    required this.time,
  });

  factory AlarmModel.fromJson(Map<String, dynamic> json)
  => _$AlarmModelFromJson(json);
}