import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EzCard extends ConsumerWidget {
  final Widget child;
  EdgeInsetsGeometry? padding;
  BoxBorder? border;
  Function()? onTap;
  EzCard(
      {super.key, required this.child, this.padding, this.border, this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding ?? const EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: colorScheme.surface,
            border: border),
        child: child,
      ),
    );
  }
}
