import 'package:ez_parky/view/layouts/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return EzScaffold(
      isDark: true,
      title: "Home",
      ezBody: Container(
          child: Center(
              child: QrImage(
        data: "asodkasodowqoejoqwj",
        version: QrVersions.auto,
        size: 400,
        embeddedImage: Image.asset("lib/assets/logo.png").image,
      ))),
    );
  }
}
