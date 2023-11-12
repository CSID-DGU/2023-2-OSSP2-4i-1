import 'package:json_annotation/json_annotation.dart';

part 'signup_response.g.dart';

@JsonSerializable()
class SignupResponse {
  final String email;
  final String id;
  final String name;

  SignupResponse({
    required this.email,
    required this.id,
    required this.name,
  });
  factory SignupResponse.fromJson(Map<String, dynamic> json)
  => _$SignupResponseFromJson(json);
}