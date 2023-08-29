import 'package:ez_parky/repository/provider/scanner_provider.dart';
import 'package:ez_parky/view/layouts/index.dart';
import 'package:ez_parky/view/screen/parking/invoice_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
      final data = await scannerNotifier.getParkingGate(barcode.rawValue!);

      if (barcode.rawValue! == data.id!) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text("Checkout"),
                  content: const Text("Apakah anda yakin ingin checkout?"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          _isScanned = false;
                          context.push(InvoiceScreen.routePath);
                        },
                        child: const Text("Ya")),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Tidak")),
                  ],
                ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("QR tidak ditemukan")));
    }
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
                    Barcode barcode = capture.barcodes.first;
                    getBarcode(barcode);
                  }
                  _isScanned = true;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
