import 'package:json_annotation/json_annotation.dart';
import 'package:shop_ease/features/auth/domain/entities/authenticated_user.dart';

part 'auth_response_model.g.dart';

@JsonSerializable()
class AuthResponseModel {
  final int id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String accessToken;
  final String refreshToken;

  AuthResponseModel({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.accessToken,
    required this.refreshToken,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseModelToJson(this);

  AuthenticatedUser toEntity() => AuthenticatedUser(
    id: id,
    username: username,
    email: email,
    firstName: firstName,
    lastName: lastName,
    accessToken: accessToken,
    refreshToken: refreshToken,
  );
}
