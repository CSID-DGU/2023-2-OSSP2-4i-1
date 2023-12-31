import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

abstract class UserModelBase {}

class UserModelError extends UserModelBase {
  final String message;

  UserModelError({
    required this.message,
  });
}

class UserModelLoading extends UserModelBase {}

class UserModelSuccess extends UserModelBase {}


@JsonSerializable()
class UserModel extends UserModelBase {
  final String name;

  UserModel({
    required this.name,
  });

  factory UserModel.fromJson(Map<String, dynamic> json)
  => _$UserModelFromJson(json);

  Map<String,dynamic> toJson() => _$UserModelToJson(this);
}