import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_ease/features/auth/domain/usecases/login_user.dart';
import 'package:shop_ease/features/auth/presentation/bloc/login_event.dart';
import 'package:shop_ease/features/auth/presentation/bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUser loginUser;

  LoginBloc({required this.loginUser}) : super(LoginInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());

    final result = await loginUser(
      LoginParams(username: event.username, password: event.password),
    );

    result.fold(
      (failure) => emit(LoginFailure(failure.message)),
      (user) => emit(LoginSuccess(user)),
    );
  }
}
