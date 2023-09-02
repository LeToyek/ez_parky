import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ez_parky/repository/model/transaction_model.dart';
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
    userRef.set({"wallet.value": FieldValue.increment(inputValue)});
  }

  Future<void> decreaseWalletValue(int inputValue, String message) async {
    final timeNow = DateTime.now().toString();
    userRef.collection("transactions").add(TransactionModel(
            value: inputValue,
            createdAt: timeNow,
            updatedAt: timeNow,
            logType: '[SUBSTRACT]',
            logMessage: message)
        .toMap());
    userRef.set({"wallet.value": FieldValue.increment(inputValue * -1)});
  }
}
