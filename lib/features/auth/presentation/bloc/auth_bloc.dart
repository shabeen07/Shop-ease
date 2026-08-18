import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_ease/features/auth/domain/repositories/auth_repository.dart';
import 'package:shop_ease/features/auth/domain/usecases/restore_session.dart';
import 'package:shop_ease/features/auth/presentation/bloc/auth_event.dart';
import 'package:shop_ease/features/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final RestoreSession restoreSession;
  final AuthRepository repository;

  AuthBloc({required this.restoreSession, required this.repository})
    : super(const AuthState.initial()) {
    on<AuthCheckRequested>(_onAuthCheckRequested);
    on<AuthUserChanged>(_onAuthUserChanged);
    on<AuthLogoutRequested>(_onAuthLogoutRequested);
  }

  Future<void> _onAuthCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    final result = await restoreSession();
    result.fold((failure) => emit(const AuthState.unauthenticated()), (user) {
      if (user != null) {
        emit(AuthState.authenticated(user));
      } else {
        emit(const AuthState.unauthenticated());
      }
    });
  }

  void _onAuthUserChanged(AuthUserChanged event, Emitter<AuthState> emit) {
    if (event.user != null) {
      emit(AuthState.authenticated(event.user!));
    } else {
      emit(const AuthState.unauthenticated());
    }
  }

  Future<void> _onAuthLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await repository.logout();
    emit(const AuthState.unauthenticated());
  }
}
