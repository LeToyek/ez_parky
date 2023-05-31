import 'package:ez_parky/view/screen/home_screen.dart';
import 'package:ez_parky/view/screen/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final _appRoutes = GoRouter(
    initialLocation:
        FirebaseAuth.instance.currentUser == null ? '/sign-in' : '/home',
    routes: [
      GoRoute(
        name: SplashScreen.routeName,
        path: SplashScreen.routePath,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        name: HomeScreen.routeName,
        path: HomeScreen.routePath,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/sign-in',
        builder: (context, state) => SignInScreen(
          actions: [
            AuthStateChangeAction<SignedIn>((context, state) {
              context.go(HomeScreen.routePath);
            }),
          ],
          styles: const {
            EmailFormStyle(signInButtonVariant: ButtonVariant.filled),
          },
          headerBuilder: (context, constraints, shrinkOffset) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            child: const Center(
              child: Text(
                'Logos',
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          footerBuilder: (context, action) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  action == AuthAction.signIn
                      ? 'By signing in, you agree to our terms and conditions.'
                      : 'By registering, you agree to our terms and conditions.',
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
            );
          },
        ),
      ),
      GoRoute(
          path: '/profile',
          builder: (context, state) => ProfileScreen(
                actions: [
                  SignedOutAction((context) {
                    context.go('/sign-in');
                  })
                ],
              )),
    ]);

final appRouteProvider = Provider((ref) => _appRoutes);
