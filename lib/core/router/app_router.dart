import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/onboarding/ui/onboarding_screen.dart';
import '../../features/products/ui/product_details_screen.dart';
import '../../features/products/ui/product_list_screen.dart';

abstract class AppRouter {
  static final GlobalKey<NavigatorState> navigatorKey =
  GlobalKey<NavigatorState>(debugLabel: 'root');

  static GoRouter? _router;

  static GoRouter getRouter({
    required bool isNotFirstLogin,
    required String token,
  }) {
    if (_router != null) return _router!;

    _router = GoRouter(
      navigatorKey: navigatorKey,
      initialLocation: getInitialLocation(isNotFirstLogin, token),
      routes: [
        GoRoute(
          path: OnboardingRoutes.routeName,
          builder: (context, state) => const OnboardingScreen(),
        ),
        GoRoute(
          path: ProductRoutes.routeName,
          builder: (context, state) => const ProductListScreen(),
          routes: [
            GoRoute(
              path: 'details/:id',
              name: ProductDetailsRoutes.routeName,
              builder: (context, state) {
                final id = int.tryParse(state.pathParameters['id'] ?? '') ?? 0;
                return ProductDetailsScreen(productId: id);
              },
            ),
          ],
        ),
      ],
    );

    return _router!;
  }

  static String getInitialLocation(bool isNotFirstLogin, String token) {
    debugPrint('isNotFirstLogin: $isNotFirstLogin, token: ${token.isNotEmpty}');
    if (!isNotFirstLogin) {
      return OnboardingRoutes.routeName;
    } else if (token.isNotEmpty) {
      return ProductRoutes.routeName;
    } else {
      return OnboardingRoutes.routeName;
    }
  }
}

extension OnboardingRoutes on OnboardingScreen {
  static const routeName = '/onboarding';
}

extension ProductRoutes on ProductListScreen {
  static const routeName = '/products';
}

extension ProductDetailsRoutes on ProductDetailsScreen {
  static const routeName = 'productDetails';
}

