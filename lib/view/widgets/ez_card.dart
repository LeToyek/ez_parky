import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EzCard extends ConsumerWidget {
  final Widget child;
  EdgeInsetsGeometry? padding;
  BoxBorder? border;
  Function()? onTap;
  Color? color;
  bool isShadow;
  EzCard(
      {super.key,
      required this.child,
      this.padding,
      this.border,
      this.onTap,
      this.color,
      this.isShadow = false});

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
            color: color ?? colorScheme.surface,
            boxShadow: isShadow
                ? [
                    const BoxShadow(
                      color: Color.fromARGB(31, 0, 0, 0),
                      blurRadius: 2.0,
                      spreadRadius: 0.0,
                      offset:
                          Offset(2.0, 2.0), // shadow direction: bottom right
                    )
                  ]
                : null,
            border: border),
        child: child,
      ),
    );
  }
}
