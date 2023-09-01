import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      backgroundColor: colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [],
        ),
      ),
    );
  }

  Widget _buildWallet(
      {required TextTheme textTheme,
      required ColorScheme colorScheme,
      required}) {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: colorScheme.primary),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Saldo Anda",
            style: textTheme.labelLarge!
                .apply(fontWeightDelta: 2, color: Colors.white),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            "Rp 1.000.000",
            style: textTheme.labelLarge!.apply(
                fontSizeDelta: 16, fontWeightDelta: 2, color: Colors.white),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(width: 1, color: Colors.white)),
                child: Row(
                  children: [
                    const Icon(
                      Icons.add_circle_rounded,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      "Top up",
                      style: textTheme.bodyLarge!.apply(color: Colors.white),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
