import 'package:ez_parky/repository/provider/scanner_provider.dart';
import 'package:ez_parky/view/layouts/index.dart';
import 'package:ez_parky/view/screen/parking/parking_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerScreen extends ConsumerWidget {
  const ScannerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scannerNotifier = ref.read(scannerProvider.notifier);
    final scanner = ref.watch(scannerProvider);
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
                    controller: MobileScannerController(
                      facing: CameraFacing.back,
                    ),
                    fit: BoxFit.cover,
                    onDetect: (capture) async {
                      try {
                        Barcode barcode = capture.barcodes.first;
                        print("data barcode: ${barcode.rawValue!}");
                        await scannerNotifier.getParkingGate(barcode.rawValue!);
                        if (context.mounted) {
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
