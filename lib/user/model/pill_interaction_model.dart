import 'package:json_annotation/json_annotation.dart';

part 'pill_interaction_model.g.dart';

@JsonSerializable()
class PillInteractionModel {
  @JsonKey(name: 'pill_name1')
  final String pillName1;
  @JsonKey(name: 'pill_name2')
  final String pillName2;
  @JsonKey(name: 'clinical_effect')
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
