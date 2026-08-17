import 'package:flutter/material.dart';
import 'package:shop_ease/app/di/injection.dart';
import 'package:shop_ease/app/router/app_router.dart';
import 'package:shop_ease/app/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp.router(
    title: 'Shop Ease',
    debugShowCheckedModeBanner: false,
    theme: AppTheme.lightTheme,
    darkTheme: AppTheme.darkTheme,
    routerConfig: AppRouter.router,
  );
}
