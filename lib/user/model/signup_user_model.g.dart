// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignupUserModel _$SignupUserModelFromJson(Map<String, dynamic> json) =>
    SignupUserModel(
      email: json['email'] as String,
      password: json['password'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$SignupUserModelToJson(SignupUserModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'name': instance.name,
    };
