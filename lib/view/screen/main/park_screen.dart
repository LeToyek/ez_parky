import 'package:ez_parky/view/layouts/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ParkScreen extends ConsumerWidget {
  const ParkScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return EzScaffold(title: 'Parkir', isDark: false, ezBody: Container());
  }
}
