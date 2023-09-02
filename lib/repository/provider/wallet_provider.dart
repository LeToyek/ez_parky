import 'package:ez_parky/repository/model/wallet_model.dart';
import 'package:ez_parky/services/wallet_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WalletNotifier extends StateNotifier<AsyncValue<WalletModel>> {
  final WalletService _walletService = WalletService();
  WalletNotifier() : super(const AsyncValue.loading());

  Future<void> initWallet() async {}

  Future<void> topUPWallet(int inputValue) async {
    try {
      const AsyncValue.loading();
      await _walletService.increaseWalletValue(inputValue);
      AsyncValue.data(inputValue);
    } catch (e) {
      AsyncValue.error(e, StackTrace.current);
    }
  }
}

final walletProvider =
    StateNotifierProvider<WalletNotifier, AsyncValue<WalletModel>>((ref) {
  return WalletNotifier();
});
