import 'package:ez_parky/view/layouts/index.dart';
import 'package:ez_parky/view/screen/content/parking_spot_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingScreen extends ConsumerWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const EzScaffold(
        title: 'Setting', isDark: false, ezBody: ParkingSpotContent());
  }
}
