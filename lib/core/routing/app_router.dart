import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reco_restaurant/core/cache_helper/shared_prefs_helper.dart';
import 'package:reco_restaurant/core/di.dart';
import 'package:reco_restaurant/core/routing/routes.dart';

import 'package:reco_restaurant/features/auth/presentation/screens/auth_screen.dart';
import 'package:reco_restaurant/features/cart/presentation/screens/cart_screen.dart';
import 'package:reco_restaurant/features/categories/presentation/screens/categories_screen.dart';
import 'package:reco_restaurant/features/deliver/presentation/screens/deliver_screen.dart';
import 'package:reco_restaurant/features/home/presentation/screens/home_screen.dart';
import 'package:reco_restaurant/features/profile/presentation/screens/profile_screen.dart';
import 'package:reco_restaurant/features/layout/presentation/screens/main_layout.dart';

class AppRouter {
  late final GoRouter router;
  final _shellNavigatorKey = GlobalKey<NavigatorState>();

  AppRouter() {
    router = GoRouter(
      initialLocation: sl<SharedPrefsHelper>().isUserLogged()
          ? Routes.home
          : Routes.auth,
      routes: [
        GoRoute(
          path: Routes.auth,
          name: Routes.auth,
          builder: (context, state) => const AuthScreen(),
        ),

        ShellRoute(
          navigatorKey: _shellNavigatorKey,
          builder: (context, state, child) => MainLayout(child: child),
          routes: [
            GoRoute(
              path: Routes.home,
              pageBuilder: (context, state) =>
                  NoTransitionPage(child: HomeScreen()),
            ),
            GoRoute(
              path: Routes.categories,
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: CategoriesScreen()),
            ),
            GoRoute(
              path: Routes.deliver,
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: DeliverScreen()),
            ),
            GoRoute(
              path: Routes.cart,
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: CartScreen()),
            ),
            GoRoute(
              path: Routes.profile,
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: ProfileScreen()),
            ),
          ],
        ),
      ],
    );
  }
}
