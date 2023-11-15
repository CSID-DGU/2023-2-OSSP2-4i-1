import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_response_model.g.dart';

@JsonSerializable()
class SearchResponseModel {
  @JsonKey(name: 'id') // JSON 키를 Dart 변수와 매핑
  int id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'img_link') // 'imgLink' 대신 'img_link' 사용
  String imgLink;

  @JsonKey(name: 'label_forms')
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

  SearchResponseModel({
    required this.id,
    required this.name,
    required this.imgLink,
    required this.labelForms,
    required this.labelShapes,
    required this.labelColor1,
    required this.labelColor2,
    this.labelLineFront = "",
    this.labelLineBack = "",
    this.labelPrintFront = "",
    this.labelPrintBack = "",
  });

  factory SearchResponseModel.fromJson(Map<String, dynamic> json) => _$SearchResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$SearchResponseModelToJson(this);

  // 웹 이미지를 위한 게터를 추가
  ImageProvider get imageProvider => NetworkImage(imgLink);

  // Image.network 위젯을 반환하는 메소드
  Widget getImageWidget({BoxFit fit = BoxFit.cover}) => Image.network(imgLink, fit: fit);
}
