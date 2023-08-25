import 'package:ez_parky/repository/provider/parking_spot_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ParkingSpotContent extends ConsumerWidget {
  const ParkingSpotContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final parkSpot = ref.watch(parkingSpotProvider);
    return Container();
  }
}
