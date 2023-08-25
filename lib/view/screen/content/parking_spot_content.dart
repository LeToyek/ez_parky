import 'package:ez_parky/repository/provider/parking_spot_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ParkingSpotContent extends ConsumerWidget {
  const ParkingSpotContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final parkSpot = ref.watch(parkingSpotProvider);
    return parkSpot.when(
      data: (data) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: data.length - 1,
              itemBuilder: (context, index) {
                return Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Column(
                    children: [
                      Icon(
                        Icons.local_car_wash_outlined,
                        color: data[index + 1]['isEmpty'] == 1
                            ? Colors.green
                            : Colors.red,
                        size: 40,
                      ),
                      Text(data[index + 1]['id'].toString()),
                    ],
                  ),
                );
              }),
        );
      },
      error: (error, stackTrace) => Text(error.toString()),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
