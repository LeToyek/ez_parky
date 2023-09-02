import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ez_parky/repository/model/transaction_model.dart';
import 'package:ez_parky/repository/model/user_model.dart';
import 'package:ez_parky/utils/formatter.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WalletService {
  WalletService._();

  static final WalletService _instance = WalletService._();

  factory WalletService() {
    return _instance;
  }
  final userRef = FirebaseFirestore.instance
      .collection("user")
      .doc(FirebaseAuth.instance.currentUser!.uid);

  Future<void> increaseWalletValue(int inputValue) async {
    final timeNow = DateTime.now().toString();
    userRef.collection("transactions").add(TransactionModel(
            value: inputValue,
            createdAt: timeNow,
            updatedAt: timeNow,
            logType: '[ADD]',
            logMessage: 'Menambah saldo sebanyak Rp ${formatMoney(inputValue)}')
        .toMap());
    userRef.update({"wallet.value": FieldValue.increment(inputValue)});
  }

  Future<bool> decreaseWalletValue(int inputValue, String message) async {
    final timeNow = DateTime.now().toString();
    final userMap = await userRef.get();
    final userWallet = UserModel.fromMap(userMap);
    if (userWallet.wallet.value < inputValue) {
      return false;
    }
    userRef.collection("transactions").add(TransactionModel(
            value: inputValue,
            createdAt: timeNow,
            updatedAt: timeNow,
            logType: '[SUBSTRACT]',
            logMessage: message)
        .toMap());
    userRef.update({"wallet.value": FieldValue.increment(inputValue * -1)});
    return true;
  }
}
