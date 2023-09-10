import 'package:ez_parky/repository/provider/parking_spot_provider.dart';
import 'package:ez_parky/repository/provider/scanner_provider.dart';
import 'package:ez_parky/utils/formatter.dart';
import 'package:ez_parky/view/screen/parking/checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ParkingScreen extends ConsumerStatefulWidget {
  const ParkingScreen({Key? key}) : super(key: key);

  static const routeName = "parking";
  static const routePath = "/parking";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ParkingScreenState();
}

class _ParkingScreenState extends ConsumerState<ParkingScreen> {
  int _filledCarCounter = 0;

  @override
  Widget build(BuildContext context) {
    final parkingData = ref.watch(scannerProvider);
    final parkSpot = ref.watch(parkingSpotProvider);
    final textTheme = Theme.of(context).textTheme;
    final colorTheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          parkingData.when(
            data: (data) {
              return SliverAppBar(
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(data.location),
                  centerTitle: true,
                ),
              );
            },
            error: (error, stackTrace) =>
                SliverToBoxAdapter(child: Text(error.toString())),
            loading: () => const SliverToBoxAdapter(
                child: Center(child: CircularProgressIndicator())),
          ),
          parkingData.when(
              error: (error, stackTrace) => SliverToBoxAdapter(
                  child: Center(child: Text(error.toString()))),
              loading: () => const SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator())),
              data: (data) {
                final parkingGate = data;

                final availParking = parkingGate.capacity - _filledCarCounter;
                final colorIcon = availParking < parkingGate.capacity
                    ? Colors.green
                    : Colors.red;
                final price = formatMoney(parkingGate.price);

                return SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.car_rental, size: 32, color: colorIcon),
                            Text(
                              "$availParking / ${parkingGate.capacity}",
                              style: textTheme.titleLarge!.apply(
                                color: colorIcon,
                                fontWeightDelta: 2,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Chip(
                              label: Text(
                                "Rp $price/jam",
                                style: textTheme.labelLarge!.apply(
                                    color: colorTheme.onPrimary,
                                    fontWeightDelta: 1),
                              ),
                              backgroundColor: colorTheme.primary,
                            )
                          ],
                        ),
                        const Divider(
                          thickness: 2,
                        )
                      ],
                    ),
                  ),
                );
              }),
          parkSpot.when(
            data: (data) {
              print("data parkir: $data");
              _filledCarCounter = 0;
              for (var element in data) {
                if (element != null && element['isEmpty'] == 1) {
                  _filledCarCounter++;
                }
              }
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
            error: (error, stackTrace) => SliverToBoxAdapter(
                child: Center(child: Text(error.toString()))),
            loading: () => const SliverToBoxAdapter(
                child: Center(child: CircularProgressIndicator())),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 2,
        child: Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity, // To fill the entire width
            child: GestureDetector(
              onTap: () {
                context.push(CheckoutScreen.routePath);
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: colorTheme.primary,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  "Keluar dan Bayar",
                  textAlign: TextAlign.center,
                  style: textTheme.labelLarge!.apply(
                    fontSizeDelta: 8,
                    color: colorTheme.onPrimary,
                    fontWeightDelta: 1,
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
