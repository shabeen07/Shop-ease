import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_ease/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:shop_ease/features/auth/presentation/bloc/auth_state.dart';

import 'package:shop_ease/features/profile/presentation/bloc/profile_event.dart';
import 'package:shop_ease/features/profile/presentation/bloc/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AuthBloc authBloc;

  ProfileBloc({required this.authBloc}) : super(const ProfileState()) {
    on<ProfileLoadRequested>(_onLoadRequested);
  }

  void _onLoadRequested(
    ProfileLoadRequested event,
    Emitter<ProfileState> emit,
  ) {
    final authState = authBloc.state;
    if (authState.status == AuthStatus.authenticated) {
      emit(state.copyWith(status: ProfileStatus.success, user: authState.user));
    } else {
      emit(state.copyWith(status: ProfileStatus.failure));
    }
  }
}
