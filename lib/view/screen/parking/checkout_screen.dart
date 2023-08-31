import 'package:ez_parky/repository/model/duration.dart';
import 'package:ez_parky/repository/provider/scanner_provider.dart';
import 'package:ez_parky/services/duration_service.dart';
import 'package:ez_parky/utils/formatter.dart';
import 'package:ez_parky/view/layouts/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
// Other imports...

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  static const routeName = "checkout";
  static const routePath = "/checkout";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => CheckoutScreenState();
}

class CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  late MobileScannerController controller;
  late bool _isScanned;

  @override
  void initState() {
    super.initState();
    controller = MobileScannerController(
      detectionSpeed: DetectionSpeed.noDuplicates,
      facing: CameraFacing.back,
    );
    _isScanned = false;
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void getBarcode(Barcode barcode) async {
    final scannerNotifier = ref.read(scannerProvider.notifier);

    try {
      final gateID = await scannerNotifier.getGateIDFromLocal();

      if (context.mounted) {
        if (barcode.rawValue! != gateID) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Theme.of(context).colorScheme.error,
              content: const Text("QR tidak ditemukan")));
          _isScanned = false;
          return;
        }
      }

      await scannerNotifier.getParkingGateForPayment(barcode.rawValue!);
      showModalBottomSheet(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(24),
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.surface,
          context: context,
          builder: (context) => _buildPaymentPopUp());
    } catch (e) {
      print("Errorr := $e");
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("QR tidak ditemukan")));
    }
  }

  Widget _buildPaymentPopUp() {
    return Consumer(builder: (context, ref, _) {
      final scannerState = ref.watch(scannerProvider);
      return scannerState.when(
          loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
          error: (error, stackTrace) => Center(
                child: Text(error.toString()),
              ),
          data: (data) {
            final timeNow = DateTime.now();
            var durationCount = data.duration;
            durationCount ??= DurationModel(
                end: timeNow.toString(), start: timeNow.toString(), price: 0);
            final dataHour = DurationService.calculateHour(durationCount.start);
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Pembayaran",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .apply(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                    fontWeightDelta: 2,
                                    fontSizeDelta: 4)),
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(data.location,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge!.apply(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeightDelta: 2,
                            fontSizeDelta: 8)),
                    const SizedBox(
                      height: 16,
                    ),
                    Text("Durasi Parkir",
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.bodyMedium!.apply(
                            color: Theme.of(context).colorScheme.onBackground,
                            fontWeightDelta: 2,
                            fontSizeDelta: 4)),
                    Text(
                        "$dataHour Jam (${formatUniversalTime(durationCount.start)} - ${formatUniversalTime(timeNow.toString())})",
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.bodyMedium!.apply(
                            color: Theme.of(context).colorScheme.onBackground,
                            fontWeightDelta: 1,
                            fontSizeDelta: 2)),
                    const SizedBox(
                      height: 16,
                    ),
                    Text("Pembayaran",
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.bodyMedium!.apply(
                            color: Theme.of(context).colorScheme.onBackground,
                            fontWeightDelta: 2,
                            fontSizeDelta: 4)),
                    _buildPaymentMethodComponent(
                        price: data.price, totalHour: dataHour)
                  ],
                ),
              ),
            );
          });
    });
  }

  Widget _buildPaymentMethodComponent(
      {required int totalHour, required int price}) {
    final finalPrice = formatMoney(totalHour * price);
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    width: 1,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(.4))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                Expanded(
                    child: Column(
                  children: [
                    Text(
                      "Total: ",
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .apply(fontWeightDelta: 2),
                    ),
                    Text("Rp $finalPrice")
                  ],
                ))
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: colorScheme.primary),
            child: Center(
              child: Text(
                "Bayar",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .apply(fontWeightDelta: 2, color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return EzScaffold(
      title: 'Keluar',
      ezBody: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Scan QR untuk keluar",
              style: textTheme.titleLarge!.apply(fontWeightDelta: 1),
            ),
            SizedBox(
              height: 300,
              width: 300,
              child: MobileScanner(
                controller: controller,
                key: const Key("scanner"),
                fit: BoxFit.cover,
                onScannerStarted: (arguments) {
                  print("scanner started");
                },
                startDelay: true,
                onDetect: (capture) {
                  if (!_isScanned) {
                    _isScanned = true;

                    Barcode barcode = capture.barcodes.first;
                    getBarcode(barcode);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
