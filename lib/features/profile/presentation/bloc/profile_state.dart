import 'package:equatable/equatable.dart';
import 'package:shop_ease/features/auth/domain/entities/authenticated_user.dart';

enum ProfileStatus { initial, loading, success, failure }

class ProfileState extends Equatable {
  final ProfileStatus status;
  final AuthenticatedUser? user;
  final String? errorMessage;

  const ProfileState({
    this.status = ProfileStatus.initial,
    this.user,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [status, user, errorMessage];

  ProfileState copyWith({
    ProfileStatus? status,
    AuthenticatedUser? user,
    String? errorMessage,
  }) => ProfileState(
    status: status ?? this.status,
    user: user ?? this.user,
    errorMessage: errorMessage ?? this.errorMessage,
  );
}
