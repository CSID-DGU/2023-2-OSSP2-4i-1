import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pill_search_model.g.dart';

@JsonSerializable()
class PillSearchModel {
  String labelForms;
  String labelShapes;
  String labelColor1;
  String labelColor2;
  String labelLineFront;
  String labelLineBack;
  String labelPrintFront;
  String labelPrintBack;

  PillSearchModel({
    required this.labelForms,
    required this.labelShapes,
    required this.labelColor1,
    required this.labelColor2,
    this.labelLineFront = "",
    this.labelLineBack = "",
    this.labelPrintFront = "",
    this.labelPrintBack = "",
  });

  factory PillSearchModel.fromJson(Map<String, dynamic> json) => _$PillSearchModelFromJson(json);

  Map<String, dynamic> toJson() => _$PillSearchModelToJson(this);
}
