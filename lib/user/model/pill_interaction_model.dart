import 'package:json_annotation/json_annotation.dart';

part 'pill_interaction_model.g.dart';

@JsonSerializable()
class PillInteractionModel {
  final String pillName1;
  final String pillName2;
  final List<String> clinicalEffect;

  PillInteractionModel({
    required this.pillName1,
    required this.pillName2,
    required this.clinicalEffect,
  });

  factory PillInteractionModel.fromJson(Map<String, dynamic> json) =>
      _$PillInteractionModelFromJson(json);

  Map<String, dynamic> toJson() => _$PillInteractionModelToJson(this);
}
