import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
part 'signup_user_model.g.dart';

@JsonSerializable()
class SignupUserModel{
  final String email;
  final String password;
  final String name;

  SignupUserModel({
    required this.email,
    required this.password,
    required this.name,
});

  factory SignupUserModel.fromJson(Map<String, dynamic> json)
  => _$SignupUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$SignupUserModelToJson(this);

}

