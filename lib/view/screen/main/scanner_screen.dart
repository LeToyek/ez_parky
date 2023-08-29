import 'package:ez_parky/repository/provider/scanner_provider.dart';
import 'package:ez_parky/view/layouts/index.dart';
import 'package:ez_parky/view/screen/parking/parking_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
// Other imports...

class ScannerScreen extends ConsumerStatefulWidget {
  const ScannerScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends ConsumerState<ScannerScreen> {
  late MobileScannerController controller;
  late bool _isScanned;
  late bool _isProcessing;

  @override
  void initState() {
    super.initState();
    controller = MobileScannerController(
      detectionSpeed: DetectionSpeed.noDuplicates,
      facing: CameraFacing.back,
    );
    _isScanned = false;
    _isProcessing = false;
  }

  @override
  void dispose() {
    super.dispose();
    _isScanned = false;
    controller.dispose();
  }

  void getBarcode(Barcode barcode) async {
    final scannerNotifier = ref.read(scannerProvider.notifier);

    try {
      setState(() {
        _isScanned = true;
      });
      setState(() {
        _isProcessing = true;
      });
      showDialog(
        context: context,
        builder: (context) => StatefulBuilder(
          builder: (context, setState) {
            return _isProcessing
                ? const AlertDialog(
                    // title: const Text("Parkir"),
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    content: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Container();
          },
        ),
      );
      await scannerNotifier.getParkingGate(barcode.rawValue!);

      setState(() {
        _isProcessing = false;
      });
      if (context.mounted) {
        context.push(ParkingScreen.routePath);
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("QR tidak ditemukan")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return EzScaffold(
      title: 'Parkir',
      ezBody: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
                    return;
                  }
                  setState(() {
                    _isScanned = false;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
