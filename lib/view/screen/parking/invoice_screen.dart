import 'package:ez_parky/repository/provider/scanner_provider.dart';
import 'package:ez_parky/services/duration_service.dart';
import 'package:ez_parky/utils/formatter.dart';
import 'package:ez_parky/view/screen/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
        final detailParkirData = [
          {"title": "Lokasi", "content": data.location},
          {
            "title": "Harga per jam",
            "content": "Rp ${formatMoney(data.price)}"
          },
          {"title": 'Tanggal Parkir', "content": data.duration!.start},
          {
            "title": "Masuk Parkir",
            "content": formatUniversalTime(data.duration!.start)
          },
          {
            "title": "Keluar Parkir",
            "content": formatUniversalTime(data.duration!.end)
          },
          {
            "title": "Total Waktu Parkir",
            "content":
                "${DurationService.calculateHour(time: data.duration!.start, comparator: data.duration!.end)} jam"
          },
        ];
        final paymentDetailData = [
          {"title": "Metode Pembayaran", "content": "Parky Cash"},
          {
            "title": "Total Pembayaran",
            "content": "Rp ${formatMoney(data.duration!.price)}"
          },
        ];
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text("Pembayaran Berhasil",
                  style: textTheme.headlineSmall!.apply(fontWeightDelta: 2)),
              const SizedBox(
                height: 16,
              ),
              Icon(
                Icons.check_circle,
                color: Colors.green.shade200,
                size: 72,
              ),
              const SizedBox(
                height: 16,
              ),
              _buildInvoiceSubTitle(textTheme, "Detail Parkir"),
              ...detailParkirData.map((e) =>
                  _buildInvoiceDetail(textTheme, e['title']!, e['content']!)),
              const SizedBox(
                height: 16,
              ),
              _buildInvoiceSubTitle(textTheme, "Pembayaran"),
              ...paymentDetailData.map((e) =>
                  _buildInvoiceDetail(textTheme, e['title']!, e['content']!)),
              const SizedBox(
                height: 16,
              ),
              Text("Terima kasih telah mempercayakan parkir kepada kami",
                  style: textTheme.bodyLarge!.apply(color: Colors.black38)),
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
              onTap: () => context.go(IndexScreen.routePath),
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
