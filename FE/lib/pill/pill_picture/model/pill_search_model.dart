  import 'package:flutter/material.dart';
  import 'package:json_annotation/json_annotation.dart';

  part 'pill_search_model.g.dart';

  @JsonSerializable()
  class PillSearchModel {
    @JsonKey(name: 'label_forms') // JSON 키를 Dart 변수와 매핑
    String labelForms;

    @JsonKey(name: 'label_shapes')
    String labelShapes;

    @JsonKey(name: 'label_color1')
    String labelColor1;

    @JsonKey(name: 'label_color2')
    String labelColor2;

    @JsonKey(name: 'label_line_front', defaultValue: "")
    String labelLineFront;

    @JsonKey(name: 'label_line_back', defaultValue: "")
    String labelLineBack;

    @JsonKey(name: 'label_print_front', defaultValue: "")
    String labelPrintFront;

    @JsonKey(name: 'label_print_back', defaultValue: "")
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
