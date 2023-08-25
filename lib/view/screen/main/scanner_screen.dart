import 'package:ez_parky/repository/provider/scanner_provider.dart';
import 'package:ez_parky/view/layouts/index.dart';
import 'package:ez_parky/view/screen/parking/parking_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerScreen extends ConsumerStatefulWidget {
  const ScannerScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends ConsumerState<ScannerScreen> {
  late MobileScannerController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = MobileScannerController(
      detectionSpeed: DetectionSpeed.noDuplicates,
      facing: CameraFacing.back,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scannerNotifier = ref.read(scannerProvider.notifier);
    // final isSubmitting = ref.watch(globalProvider);
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
                    onDetect: (capture) async {
                      try {
                        Barcode barcode = capture.barcodes.first;
                        print("data barcode: ${barcode.rawValue!}");
                        await scannerNotifier.getParkingGate(barcode.rawValue!);
                        if (context.mounted) {
                          controller.stop();
                          context.push(ParkingScreen.routePath);
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("QR tidak ditemukan")));
                      }
                      // context.push('/profile');
                    }),
              ),
            ],
          ),
        ));
  }
}
