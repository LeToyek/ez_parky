import 'package:ez_parky/repository/provider/user_provider.dart';
import 'package:ez_parky/services/wallet_service.dart';
import 'package:ez_parky/utils/formatter.dart';
import 'package:ez_parky/view/widgets/ez_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class WalletManagerScreen extends ConsumerStatefulWidget {
  static const routePath = "/wallet-manager";
  static const routeName = "wallet-manager";
  final List<Map<String, dynamic>> nominalValue = [
    {"value": 20000, "icon": "lib/assets/money-1"},
    {"value": 40000, "icon": "lib/assets/money-2"},
    {"value": 80000, "icon": "lib/assets/money-3"},
    {"value": 100000, "icon": "lib/assets/money-4"},
    {"value": 120000, "icon": "lib/assets/money-5"},
    {"value": 160000, "icon": "lib/assets/money-6"},
  ];
  WalletManagerScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _WalletManagerScreenState();
}

class _WalletManagerScreenState extends ConsumerState<WalletManagerScreen> {
  int selectedTopUpValue = 0;
  final bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Top up"),
          centerTitle: true,
          bottom: const TabBar(indicatorColor: Colors.white, tabs: [
            Tab(
              text: "Cepat",
            ),
            Tab(text: "Metode Lain")
          ]),
          elevation: .3,
        ),
        backgroundColor: colorScheme.background,
        body: TabBarView(
          children: [
            _buildQuickPage(textTheme, colorScheme),
            _buildOtherPage(textTheme, colorScheme)
          ],
        ),
      ),
    );
  }

  Widget _buildQuickPage(TextTheme textTheme, ColorScheme colorScheme) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          EzCard(
            padding: const EdgeInsets.all(12),
            child: Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Pilih nominal uang",
                        style: textTheme.labelLarge!
                            .apply(fontWeightDelta: 2, fontSizeDelta: 4),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  SizedBox(
                      height: 300,
                      child: GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        crossAxisCount: 3,
                        children: [
                          ...List.generate(6, (index) {
                            final iconCard = widget.nominalValue[index]['icon'];
                            final topUpValue =
                                widget.nominalValue[index]['value'];
                            return _buildMoneyCard(
                                textTheme: textTheme,
                                iconCard: iconCard,
                                topUpValue: topUpValue);
                          })
                        ],
                      ))
                ],
              ),
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(12),
            child: GestureDetector(
              onTap: () =>
                  _onPayTopUp(context: context, value: selectedTopUpValue),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: colorScheme.primary),
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Bayar",
                      style: textTheme.bodyLarge!.apply(
                          fontSizeDelta: 4,
                          fontWeightDelta: 3,
                          color: Colors.white),
                    ),
                    Text(
                      "Rp ${formatMoney(selectedTopUpValue)}",
                      style: textTheme.bodyLarge!.apply(
                          fontSizeDelta: 4,
                          fontWeightDelta: 3,
                          color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMoneyCard(
      {required TextTheme textTheme,
      required String iconCard,
      required int topUpValue}) {
    final value = formatMoney(topUpValue);
    return EzCard(
        onTap: () => setState(() {
              selectedTopUpValue = topUpValue;
            }),
        border: Border.all(
            style: BorderStyle.solid, width: 4, color: Colors.grey.shade200),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "$iconCard.png",
              height: 54,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              "Rp $value",
              style: textTheme.bodyMedium!.apply(fontWeightDelta: 2),
            ),
          ],
        ));
  }

  Widget _buildOtherPage(TextTheme textTheme, ColorScheme colorScheme) {
    return Column(
      children: [
        EzCard(
          child: const Text("other page"),
        )
      ],
    );
  }

  void _onPayTopUp({required BuildContext context, required int value}) async {
    final userRef = ref.read(userProvider.notifier);
    if (value != 0) {
      WalletService walletService = WalletService();

      await walletService.increaseWalletValue(value);
      await userRef.initUserState();
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            // title: const Text("Parkir"),
            elevation: 0,
            backgroundColor: Colors.transparent,
            content: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      );

      if (context.mounted) {
        Future.delayed(const Duration(seconds: 1))
            .then((value) => context.pop());
      }
    }
  }
}
