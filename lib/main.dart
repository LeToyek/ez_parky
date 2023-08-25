import 'package:ez_parky/routes/index.dart';
import 'package:ez_parky/view/theme/index.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_auth/src/providers/email_auth_provider.dart'
    as email_auth;
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  FirebaseUIAuth.configureProviders([
    email_auth.EmailAuthProvider(),
    GoogleProvider(clientId: dotenv.env['GOOGLE_CLIENT_ID'].toString())
  ]);

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouteProvider);
    return MaterialApp.router(
      title: 'ez parky',
      routerConfig: router,
      theme: ezThemeData,
    );
  }
}
