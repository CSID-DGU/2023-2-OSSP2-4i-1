import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pill_model.g.dart';

@JsonSerializable()
class Pill {
  int id;
  String name;
  String assetName; // 로컬 에셋의 이름을 저장할 변수

  Pill({
    required this.id,
    required this.name,
    required this.assetName,
  });

  factory Pill.fromJson(Map<String, dynamic> json)
  => _$PillFromJson(json);

  Map<String,dynamic> toJson() => _$PillToJson(this);

  // 로컬 에셋 이미지를 위한 게터를 추가
  ImageProvider get imageProvider => AssetImage(assetName);

  // Image.asset 위젯을 반환하는 메소드
  Widget getImageWidget({BoxFit fit = BoxFit.cover}) => Image.asset(assetName, fit: fit);
}
