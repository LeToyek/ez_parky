import 'package:ez_parky/repository/provider/parking_spot_provider.dart';
import 'package:ez_parky/repository/provider/scanner_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ParkingScreen extends ConsumerStatefulWidget {
  const ParkingScreen({Key? key}) : super(key: key);

  static const routeName = "parking";
  static const routePath = "/parking";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ParkingScreenState();
}

class _ParkingScreenState extends ConsumerState<ParkingScreen> {
  @override
  Widget build(BuildContext context) {
    final parkingData = ref.watch(scannerProvider);
    final parkSpot = ref.watch(parkingSpotProvider);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            flexibleSpace: FlexibleSpaceBar(
              title: Text("Parking"),
            ),
          ),
          parkSpot.when(
            data: (data) {
              return SliverGrid.builder(
                  itemCount: data.length - 1,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
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
                  });
            },
            error: (error, stackTrace) =>
                SliverToBoxAdapter(child: Text(error.toString())),
            loading: () => const SliverToBoxAdapter(
                child: Center(child: CircularProgressIndicator())),
          )
        ],
      ),
    );
  }
}
