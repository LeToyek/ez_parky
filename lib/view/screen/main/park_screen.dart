import 'package:ez_parky/repository/provider/global_provider.dart';
import 'package:ez_parky/view/layouts/index.dart';
import 'package:ez_parky/view/screen/content/main_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ParkScreen extends ConsumerWidget {
  const ParkScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSubmitting = ref.watch(globalProvider);
    return EzScaffold(
      title: 'Parkir',
      isDark: false,
      ezBody: isSubmitting
          ? const MainContent()
          : SizedBox(
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
                        onDetect: (capture) {
                          Barcode barcode = capture.barcodes.first;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(barcode.rawValue!),
                            ),
                          );
                          // context.push('/profile');
                        }),
                  ),
                ],
              ),
            ),
    );
  }
}
