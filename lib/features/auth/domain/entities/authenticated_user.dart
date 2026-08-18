import 'package:equatable/equatable.dart';

class AuthenticatedUser extends Equatable {
  final int id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String accessToken;
  final String refreshToken;

  const AuthenticatedUser({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.accessToken,
    required this.refreshToken,
  });

  @override
  List<Object?> get props => [id, username, email, accessToken, refreshToken];
}
