import 'package:ez_parky/repository/provider/qr_code.dart';
import 'package:ez_parky/view/layouts/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:uuid/uuid.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final qrData = ref.watch(QrCodeProvider);
    return EzScaffold(
      isDark: true,
      title: "Home",
      ezBody: Center(
          child: qrData.when(
              data: (data) {
                return QrImage(
                  data: const Uuid().v4(),
                  version: QrVersions.auto,
                  size: 300,
                  embeddedImage: Image.asset("lib/assets/logo.png").image,
                );
              },
              error: (error, stackTrace) => Text('Error $error $stackTrace'),
              loading: () => const CircularProgressIndicator())),
    );
  }
}
