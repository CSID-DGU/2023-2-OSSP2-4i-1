import 'package:json_annotation/json_annotation.dart';

part 'pill_detail_model.g.dart';

@JsonSerializable()
class PillDetailModel {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'idx')
  String idx;

  @JsonKey(name: 'drug_name')
  String drugName;

  @JsonKey(name: 'pill_effect')
  String pillEffect;

  @JsonKey(name: 'pill_amount')
  String pillAmount;

  @JsonKey(name: 'pill_detail')
  String pillDetail;

  @JsonKey(name: 'pill_method')
  String pillMethod;

  @JsonKey(name: 'pill_food')
  String pillFood;

  @JsonKey(name: 'inter_x')
  int interX;

  @JsonKey(name: 'pill_inter')
  String pillInter;

  PillDetailModel({
    required this.id,
    required this.idx,
    required this.drugName,
    required this.pillEffect,
    required this.pillAmount,
    required this.pillDetail,
    required this.pillMethod,
    required this.pillFood,
    required this.interX,
    required this.pillInter,
  });

  factory PillDetailModel.fromJson(Map<String, dynamic> json) => _$PillDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$PillDetailModelToJson(this);
}
