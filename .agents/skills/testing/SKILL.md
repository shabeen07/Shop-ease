---
name: testing
description: Technical patterns for writing unit, BLoC, and widget tests in Shop Ease.
---

# Testing Skills & Patterns

## 1. Unit Testing (Use Cases & Repositories)
Pattern for testing a Use Case:
```dart
void main() {
  late MockRepository mockRepository;
  late MyUseCase useCase;

  setUp(() {
    mockRepository = MockRepository();
    useCase = MyUseCase(mockRepository);
  });

  test('should return Data when repository call is successful', () async {
    // Arrange
    when(() => mockRepository.getData()).thenAnswer((_) async => Right(tData));
    // Act
    final result = await useCase(Params(id: tId));
    // Assert
    expect(result, Right(tData));
    verify(() => mockRepository.getData()).called(1);
  });
}
```

## 2. BLoC Testing (`bloc_test`)
Pattern for testing a BLoC:
```dart
blocTest<MyBloc, MyState>(
  'emits [Loading, Success] when MyEvent is added',
  build: () {
    when(() => mockUseCase(any())).thenAnswer((_) async => Right(tResult));
    return MyBloc(myUseCase: mockUseCase);
  },
  act: (bloc) => bloc.add(MyEvent()),
  expect: () => [
    MyLoading(),
    MySuccess(data: tResult),
  ],
  verify: (_) {
    verify(() => mockUseCase(any())).called(1);
  },
);
```

## 3. Widget Testing with Mocking
Pattern for mocking dependencies in Widget tests:
```dart
void main() {
  late MockMyBloc mockMyBloc;

  setUp(() {
    mockMyBloc = MockMyBloc();
  });

  Widget createWidgetUnderTest() {
    return BlocProvider<MyBloc>.value(
      value: mockMyBloc,
      child: const MaterialApp(home: MyPage()),
    );
  }

  testWidgets('should show loading indicator when state is Loading', (tester) async {
    when(() => mockMyBloc.state).thenReturn(MyLoading());
    await tester.pumpWidget(createWidgetUnderTest());
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
```

## 4. Common Mocking Tasks
- **Mocking Repositories:** `class MockAuthRepository extends Mock implements AuthRepository {}`
- **Mocking Use Cases:** `class MockLoginUser extends Mock implements LoginUser {}`
- **Mocking BLoCs:** `class MockHomeBloc extends MockBloc<HomeEvent, HomeState> implements HomeBloc {}`
