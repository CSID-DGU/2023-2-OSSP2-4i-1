import 'package:json_annotation/json_annotation.dart';
import 'package:yakmoya/pill/pill_picture/model/search_response_model.dart';

part 'pill_detail_model.g.dart';

@JsonSerializable()
class PillDetailModel extends SearchResponseModel {
  @JsonKey(name: 'pill_effect')
  String pillEffect;

  @JsonKey(name: 'pill_detail')
  String pillDetail;

  @JsonKey(name: 'pill_method')
  String pillMethod;

  PillDetailModel({
    required super.id,
    required super.name,
    required super.imgLink,
    required this.pillEffect,
    required this.pillDetail,
    required this.pillMethod,
  });

  factory PillDetailModel.fromJson(Map<String, dynamic> json) => _$PillDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$PillDetailModelToJson(this);
}
