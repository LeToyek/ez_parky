import 'package:ez_parky/repository/provider/user_provider.dart';
import 'package:ez_parky/services/user_service.dart';
import 'package:ez_parky/view/screen/index.dart';
import 'package:ez_parky/view/screen/parking/checkout_screen.dart';
import 'package:ez_parky/view/screen/parking/invoice_screen.dart';
import 'package:ez_parky/view/screen/parking/parking_screen.dart';
import 'package:ez_parky/view/screen/splash_screen.dart';
import 'package:ez_parky/view/screen/wallet/manager_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final currentUser = FirebaseAuth.instance.currentUser;

final _appRoutes =
    GoRouter(initialLocation: currentUser == null ? '/sign-in' : '/', routes: [
  GoRoute(
    name: SplashScreen.routeName,
    path: SplashScreen.routePath,
    builder: (context, state) => const SplashScreen(),
  ),
  GoRoute(
    name: IndexScreen.routeName,
    path: IndexScreen.routePath,
    builder: (context, state) => const IndexScreen(),
  ),
  GoRoute(
    name: "sign-in",
    path: "/sign-in",
    builder: (context, state) => SignInScreen(
      actions: [
        AuthStateChangeAction<SignedIn>((context, state) async {
          await UserService.initUserData();
          if (context.mounted) {
            context.pushReplacement(IndexScreen.routePath);
          }
        }),
      ],
      headerBuilder: (context, constraints, shrinkOffset) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: const Center(
          child: Text(
            'Logo',
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
    path: '/sign-ina',
    builder: (context, state) => StatefulBuilder(builder: (context, setState) {
      bool isProcessing = false;
      return Consumer(builder: (context, ref, _) {
        final userNotifier = ref.read(userProvider.notifier);
        return SignInScreen(
          actions: [
            AuthStateChangeAction<SignedIn>((context, state) async {
              setState(() {
                isProcessing = true;
              });
              try {
                await UserService.initUserData();
                showDialog(
                  context: context,
                  builder: (context) => StatefulBuilder(
                    builder: (context, setState) {
                      return isProcessing
                          ? const AlertDialog(
                              // title: const Text("Parkir"),
                              elevation: 0,
                              backgroundColor: Colors.transparent,
                              content: Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : Container();
                    },
                  ),
                );
                userNotifier.initUserState();
                setState(() => isProcessing = false);
                if (context.mounted) {
                  context.go(IndexScreen.routePath);
                }
              } catch (e) {}
            }),
          ],
          styles: const {
            EmailFormStyle(signInButtonVariant: ButtonVariant.filled),
          },
          headerBuilder: (context, constraints, shrinkOffset) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            child: const Center(
              child: Text(
                'Logo',
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
        );
      });
    }),
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
  GoRoute(
      path: ParkingScreen.routePath,
      name: ParkingScreen.routeName,
      builder: (context, state) => const ParkingScreen()),
  GoRoute(
      path: CheckoutScreen.routePath,
      name: CheckoutScreen.routeName,
      builder: (context, state) => const CheckoutScreen()),
  GoRoute(
      path: InvoiceScreen.routePath,
      name: InvoiceScreen.routeName,
      builder: (context, state) => const InvoiceScreen()),
  GoRoute(
    path: WalletManagerScreen.routePath,
    name: WalletManagerScreen.routeName,
    builder: (context, state) => WalletManagerScreen(),
  )
]);

final appRouteProvider = Provider((ref) => _appRoutes);
