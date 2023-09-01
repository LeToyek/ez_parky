import 'package:ez_parky/repository/model/wallet_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WalletNotifier extends StateNotifier<AsyncValue<WalletModel>> {
  WalletNotifier() : super(const AsyncValue.loading());

  Future<void> initWallet() async {}
}

final walletProvider =
    StateNotifierProvider<WalletNotifier, AsyncValue<WalletModel>>((ref) {
  return WalletNotifier();
});
