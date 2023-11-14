import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_response.g.dart';

@JsonSerializable()
class SearchResponse {
  int id;
  String name;
  String imgLink;
  String labelForms;
  String labelShapes;
  String labelColor1;
  String labelColor2;
  String labelLineFront;
  String labelLineBack;
  String labelPrintFront;
  String labelPrintBack;

  SearchResponse({
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

  factory SearchResponse.fromJson(Map<String, dynamic> json) => _$SearchResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchResponseToJson(this);

  // 웹 이미지를 위한 게터를 추가
  ImageProvider get imageProvider => NetworkImage(imgLink);

  // Image.network 위젯을 반환하는 메소드
  Widget getImageWidget({BoxFit fit = BoxFit.cover}) => Image.network(imgLink, fit: fit);
}
