import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_ease/app/di/injection.dart';
import 'package:shop_ease/app/router/app_router.dart';
import 'package:shop_ease/app/theme/app_theme.dart';
import 'package:shop_ease/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:shop_ease/features/auth/presentation/bloc/auth_event.dart';
import 'package:shop_ease/features/settings/domain/entities/app_settings.dart';
import 'package:shop_ease/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:shop_ease/features/settings/presentation/bloc/settings_event.dart';
import 'package:shop_ease/features/settings/presentation/bloc/settings_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
    providers: [
      BlocProvider<SettingsBloc>(
        create: (context) =>
            getIt<SettingsBloc>()..add(SettingsLoadRequested()),
      ),
      BlocProvider<AuthBloc>(
        create: (context) => getIt<AuthBloc>()..add(AuthCheckRequested()),
      ),
    ],
    child: BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) => MaterialApp.router(
        title: 'Shop Ease',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: _mapThemeMode(state.settings.themeMode),
        routerConfig: AppRouter.router,
      ),
    ),
  );

  ThemeMode _mapThemeMode(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.system:
        return ThemeMode.system;
    }
  }
}
