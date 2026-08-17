import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_ease/app/router/route_names.dart';
import 'package:shop_ease/features/auth/presentation/pages/login_page.dart';
import 'package:shop_ease/features/product_detail/presentation/pages/product_detail_page.dart';
import 'package:shop_ease/features/products/presentation/pages/home_page.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/login',
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
        builder: (context, state) =>
            const Scaffold(body: Center(child: Text('Notifications Page'))),
      ),
      GoRoute(
        path: '/profile',
        name: RouteNames.profile,
        builder: (context, state) =>
            const Scaffold(body: Center(child: Text('Profile Page'))),
        routes: [
          GoRoute(
            path: 'settings',
            name: RouteNames.settings,
            builder: (context, state) =>
                const Scaffold(body: Center(child: Text('Settings Page'))),
          ),
        ],
      ),
    ],
  );
}
