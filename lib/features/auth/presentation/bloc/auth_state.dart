import 'package:equatable/equatable.dart';
import 'package:shop_ease/features/auth/domain/entities/authenticated_user.dart';

enum AuthStatus { initial, authenticated, unauthenticated }

class AuthState extends Equatable {
  final AuthStatus status;
  final AuthenticatedUser? user;

  const AuthState._({this.status = AuthStatus.initial, this.user});

  const AuthState.initial() : this._();

  const AuthState.authenticated(AuthenticatedUser user)
    : this._(status: AuthStatus.authenticated, user: user);

  const AuthState.unauthenticated()
    : this._(status: AuthStatus.unauthenticated);

  @override
  List<Object?> get props => [status, user];
}
