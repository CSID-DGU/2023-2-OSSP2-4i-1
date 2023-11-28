import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_pill_model.g.dart';

abstract class UserPillModelBase {}

class UserPillModelLoading extends UserPillModelBase {}

class UserPillModelError extends UserPillModelBase {
  final String message;

  UserPillModelError({required this.message});
}

class UserPillModelSuccess extends UserPillModelBase {
  final List<UserPillModel> pills;

  UserPillModelSuccess({required this.pills});
}
@JsonSerializable()
class UserPillModel extends UserPillModelBase{
  String id;
  String name;
  String img;

  UserPillModel({
    required this.id,
    required this.name,
    required this.img,
});

  factory UserPillModel.fromJson(Map<String, dynamic> json)
  => _$UserPillModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserPillModelToJson(this);

}