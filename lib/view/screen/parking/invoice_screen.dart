import 'package:ez_parky/repository/provider/scanner_provider.dart';
import 'package:ez_parky/utils/formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InvoiceScreen extends ConsumerWidget {
  const InvoiceScreen({super.key});

  static const routeName = 'invoice';
  static const routePath = '/invoice';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorTheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final parkingData = ref.watch(scannerProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Invoice'),
        backgroundColor: colorTheme.primary,
      ),
      body: parkingData.when(data: (data) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'Bukti Pembayaran',
                style: textTheme.headlineMedium,
              ),
              const SizedBox(
                height: 16,
              ),
              _buildInvoiceSubTitle(textTheme, "Detail Parkir"),
              _buildInvoiceDetail(textTheme, 'Lokasi', data.location),
              _buildInvoiceDetail(
                  textTheme, 'Harga per jam', "Rp ${formatMoney(data.price)}"),
            ],
          ),
        );
      }, error: (error, stackTrace) {
        return Center(
          child: Text(error.toString()),
        );
      }, loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }),
      bottomNavigationBar: BottomAppBar(
        elevation: 2,
        child: Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity, // To fill the entire width
            child: GestureDetector(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: colorTheme.primary,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  "Kembali ke Beranda",
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

  Widget _buildInvoiceSubTitle(TextTheme textTheme, String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                title,
                style: textTheme.titleMedium!.apply(fontWeightDelta: 2),
              ),
            ],
          ),
          const Divider()
        ],
      ),
    );
  }

  Widget _buildInvoiceDetail(
      TextTheme textTheme, String title, String content) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: textTheme.bodyLarge,
          ),
          Text(
            content,
            style: textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
