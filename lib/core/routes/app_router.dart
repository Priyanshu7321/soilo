import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/screens/auth_screen.dart';
import '../../features/auth/presentation/view_models/auth_view_model.dart';
import '../../features/history/presentation/screens/history_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateChangesProvider);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        pageBuilder: (context, state) => const MaterialPage(
          child: Scaffold(
            body: Center(child: CircularProgressIndicator()),
          ),
        ),
      ),
      GoRoute(
        path: '/auth',
        builder: (context, state) => const AuthScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/history',
        builder: (context, state) => const HistoryScreen(),
      ),
    ],
    redirect: (context, state) {
      final isLoading = authState.isLoading;
      final isLoggedIn = authState.valueOrNull != null;

      final isSplash = state.matchedLocation == '/splash';
      final isAuthRoute = state.matchedLocation == '/auth';
      final isAppRoute = ['/home', '/history'].contains(state.matchedLocation);

      // Still loading → stay on splash
      if (isLoading) return isSplash ? null : '/splash';

      // Splash → redirect to auth/home
      if (isSplash) return isLoggedIn ? '/home' : '/auth';

      // Already logged in → block auth route
      if (isAuthRoute && isLoggedIn) return '/home';

      // Not logged in → block app routes
      if (isAppRoute && !isLoggedIn) return '/auth';

      return null;
    },
  );
});
