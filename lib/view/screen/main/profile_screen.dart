import 'package:ez_parky/view/layouts/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EzProfileScreen extends ConsumerWidget {
  const EzProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return EzScaffold(title: 'Profile', ezBody: Container());
  }
}
