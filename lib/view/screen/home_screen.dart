import 'package:ez_parky/view/layouts/index.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  static const routePath = '/home';
  static const routeName = 'Home';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return EzScaffold(
      ezBody: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  print(dotenv.env['GOOGLE_CLIENT_ID'].toString());
                },
                child: const Text("test")),
            ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  // ignore: use_build_context_synchronously
                  context.go('/sign-in');
                },
                child: const Text('Sign OUT')),
            ElevatedButton(
                onPressed: () {
                  context.push('/profile');
                },
                child: const Text('Profile')),
            Text(
              'Halo',
              style: Theme.of(context).textTheme.titleLarge,
            )
          ],
        ),
      ),
    );
  }
}
