import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:yakmoya/pill/pill_picture/model/model_with_id.dart';

part 'search_response_model.g.dart';

@JsonSerializable()
class SearchResponseModel implements IModelWithId {
  @override
  int id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'img_link') // 'imgLink' 대신 'img_link' 사용
  String imgLink;

  SearchResponseModel({
    required this.id,
    required this.name,
    required this.imgLink,
  });

  factory SearchResponseModel.fromJson(Map<String, dynamic> json) => _$SearchResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$SearchResponseModelToJson(this);

  // 웹 이미지를 위한 게터를 추가
  ImageProvider get imageProvider => NetworkImage(imgLink);

  // Image.network 위젯을 반환하는 메소드
  Widget getImageWidget({BoxFit fit = BoxFit.cover}) => Image.network(imgLink, fit: fit);
}
