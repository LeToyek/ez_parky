import 'package:ez_parky/repository/model/transaction_model.dart';
import 'package:ez_parky/repository/model/user_model.dart';
import 'package:ez_parky/repository/provider/user_provider.dart';
import 'package:ez_parky/utils/formatter.dart';
import 'package:ez_parky/view/screen/wallet/manager_screen.dart';
import 'package:ez_parky/view/widgets/ez_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final userRef = ref.watch(userProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      backgroundColor: colorScheme.background,
      body: userRef.when(loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }, error: (error, stackTrace) {
        return Center(
          child: Text("$error"),
        );
      }, data: (data) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildWallet(
                  context: context,
                  textTheme: textTheme,
                  colorScheme: colorScheme,
                  userData: data),
              const SizedBox(
                height: 16,
              ),
              Expanded(
                child: EzCard(
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Riwayat Transaksi",
                              style: textTheme.labelLarge!
                                  .apply(fontWeightDelta: 2),
                            ),
                            InkWell(
                              onTap: () =>
                                  context.push(WalletManagerScreen.routePath),
                              child: Text(
                                "Lihat Semua",
                                style: textTheme.bodyLarge!
                                    .apply(color: colorScheme.primary),
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                            itemCount: data.transactions!.length,
                            shrinkWrap: true,
                            // physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final transaction = data.transactions![index];
                              return _logCard(transaction: transaction);
                            }),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }

  Widget _buildWallet(
      {required BuildContext context,
      required TextTheme textTheme,
      required ColorScheme colorScheme,
      required UserModel userData}) {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: colorScheme.primary),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Saldo Anda",
            style: textTheme.labelLarge!
                .apply(fontWeightDelta: 2, color: Colors.white),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            "Rp ${formatMoney(userData.wallet.value)}",
            style: textTheme.labelLarge!.apply(
                fontSizeDelta: 16, fontWeightDelta: 2, color: Colors.white),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(),
              InkWell(
                onTap: () => context.push(WalletManagerScreen.routePath),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(width: 1, color: Colors.white)),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.add_circle_rounded,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        "Top up",
                        style: textTheme.bodyLarge!.apply(color: Colors.white),
                      )
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _logCard({required TransactionModel transaction}) {
    final isAdd = transaction.logType == "[ADD]";
    return Column(
      children: [
        Container(
          // margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: isAdd ? Colors.green.shade100 : Colors.red.shade100),
                child: isAdd
                    ? Icon(
                        Icons.arrow_upward,
                        color: Colors.green.shade400,
                      )
                    : Icon(
                        Icons.arrow_downward,
                        color: Colors.red.shade400,
                      ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          transaction.logMessage,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(formatUniversalDate(transaction.createdAt))
                      ],
                    ),
                    Column(
                      children: [
                        Text("Rp ${formatMoney(transaction.value)}"),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        const Divider()
      ],
    );
  }
}
