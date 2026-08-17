import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shop_ease/core/error/failures.dart';
import 'package:shop_ease/features/auth/domain/entities/authenticated_user.dart';
import 'package:shop_ease/features/auth/domain/usecases/login_user.dart';
import 'package:shop_ease/features/auth/presentation/bloc/login_bloc.dart';
import 'package:shop_ease/features/auth/presentation/bloc/login_event.dart';
import 'package:shop_ease/features/auth/presentation/bloc/login_state.dart';

class MockLoginUser extends Mock implements LoginUser {}

void main() {
  late LoginBloc bloc;
  late MockLoginUser mockLoginUser;

  setUp(() {
    mockLoginUser = MockLoginUser();
    bloc = LoginBloc(loginUser: mockLoginUser);

    registerFallbackValue(LoginParams(username: '', password: ''));
  });

  tearDown(() {
    bloc.close();
  });

  const tUsername = 'emilys';
  const tPassword = 'emilyspass';
  const tAuthenticatedUser = AuthenticatedUser(
    id: 1,
    username: 'emilys',
    email: 'emily@example.com',
    firstName: 'Emily',
    lastName: 'Johnson',
    accessToken: 'token',
    refreshToken: 'refresh',
  );

  test('initial state should be LoginInitial', () {
    expect(bloc.state, equals(LoginInitial()));
  });

  blocTest<LoginBloc, LoginState>(
    'should emit [LoginLoading, LoginSuccess] when login is successful',
    build: () {
      when(
        () => mockLoginUser(any()),
      ).thenAnswer((_) async => const Right(tAuthenticatedUser));
      return bloc;
    },
    act: (bloc) => bloc.add(
      const LoginSubmitted(username: tUsername, password: tPassword),
    ),
    expect: () => [LoginLoading(), const LoginSuccess(tAuthenticatedUser)],
    verify: (_) {
      verify(() => mockLoginUser(any())).called(1);
    },
  );

  blocTest<LoginBloc, LoginState>(
    'should emit [LoginLoading, LoginFailure] when login fails',
    build: () {
      when(() => mockLoginUser(any())).thenAnswer(
        (_) async => const Left(ServerFailure('Invalid credentials')),
      );
      return bloc;
    },
    act: (bloc) => bloc.add(
      const LoginSubmitted(username: tUsername, password: tPassword),
    ),
    expect: () => [LoginLoading(), const LoginFailure('Invalid credentials')],
  );
}
