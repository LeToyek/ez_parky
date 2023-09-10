import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ez_parky/repository/model/transaction_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TransactionService {
  final _currentUser = FirebaseAuth.instance.currentUser;
  late CollectionReference _transactionRef;
  TransactionService() {
    _transactionRef = FirebaseFirestore.instance
        .collection('user')
        .doc(_currentUser!.uid)
        .collection('transactions');
  }
  Future<List<TransactionModel>> getTransactions() async {
    try {
      final res =
          await _transactionRef.orderBy("createdAt", descending: true).get();
      final data = res.docs.map((e) => TransactionModel.fromMap(e)).toList();
      return data;
    } catch (e) {
      rethrow;
    }
  }
}
