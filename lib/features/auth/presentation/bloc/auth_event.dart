import 'package:equatable/equatable.dart';
import 'package:shop_ease/features/auth/domain/entities/authenticated_user.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props => [];
}

class AuthCheckRequested extends AuthEvent {}

class AuthUserChanged extends AuthEvent {
  final AuthenticatedUser? user;
  const AuthUserChanged(this.user);
  @override
  List<Object?> get props => [user];
}

class AuthLogoutRequested extends AuthEvent {}
