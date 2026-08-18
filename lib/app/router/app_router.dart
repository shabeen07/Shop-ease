import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_ease/app/di/injection.dart';
import 'package:shop_ease/app/router/route_names.dart';
import 'package:shop_ease/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:shop_ease/features/auth/presentation/bloc/auth_state.dart';
import 'package:shop_ease/features/auth/presentation/pages/login_page.dart';
import 'package:shop_ease/features/notifications/presentation/pages/notifications_page.dart';
import 'package:shop_ease/features/product_detail/presentation/pages/product_detail_page.dart';
import 'package:shop_ease/features/products/presentation/pages/home_page.dart';
import 'package:shop_ease/features/profile/presentation/pages/profile_page.dart';
import 'package:shop_ease/features/settings/presentation/pages/settings_page.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/login',
    refreshListenable: _GoRouterRefreshStream(getIt<AuthBloc>().stream),
    redirect: (context, state) {
      final authStatus = getIt<AuthBloc>().state.status;
      final isLoggingIn = state.matchedLocation == '/login';

      if (authStatus == AuthStatus.unauthenticated && !isLoggingIn) {
        return '/login';
      }
      if (authStatus == AuthStatus.authenticated && isLoggingIn) {
        return '/home';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        name: RouteNames.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/home',
        name: RouteNames.home,
        builder: (context, state) => const HomePage(),
        routes: [
          GoRoute(
            path: 'detail/:id',
            name: RouteNames.productDetail,
            builder: (context, state) {
              final id = int.parse(state.pathParameters['id']!);
              return ProductDetailPage(productId: id);
            },
          ),
        ],
      ),
      GoRoute(
        path: '/notifications',
        name: RouteNames.notifications,
        builder: (context, state) => const NotificationsPage(),
      ),
      GoRoute(
        path: '/profile',
        name: RouteNames.profile,
        builder: (context, state) => const ProfilePage(),
        routes: [
          GoRoute(
            path: 'settings',
            name: RouteNames.settings,
            builder: (context, state) => const SettingsPage(),
          ),
        ],
      ),
    ],
  );
}

class _GoRouterRefreshStream extends ChangeNotifier {
  _GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.listen((_) => notifyListeners());
  }

  late final dynamic _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
