import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/onboarding/ui/onboarding_screen.dart';
import '../../features/products/ui/product_details_screen.dart';
import '../../features/products/ui/product_list_screen.dart';
import '../../features/splash/ui/splash_screen.dart';

final _rootKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final appRouter = GoRouter(
  navigatorKey: _rootKey,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      name: 'onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/products',
      name: 'products',
      builder: (context, state) => const ProductListScreen(),
      routes: [
        GoRoute(
          path: 'details/:id',
          name: 'productDetails',
          builder: (context, state) {
            final id = int.tryParse(state.pathParameters['id'] ?? '') ?? 0;
            return ProductDetailsScreen(productId: id);
          },
        ),
      ],
    ),
  ],
);
