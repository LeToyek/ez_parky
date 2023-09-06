import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ez_parky/repository/model/user_model.dart';
import 'package:ez_parky/services/transaction_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserNotifier extends StateNotifier<AsyncValue<UserModel>> {
  UserNotifier() : super(const AsyncValue.loading());

  CollectionReference userRef = FirebaseFirestore.instance.collection('user');
  final _transactionService = TransactionService();

  Future<void> initUserState() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      state = const AsyncValue.loading();
      final res = await userRef.doc(user!.uid).get();
      final userTransactions = await _transactionService.getTransactions();
      final userData = UserModel.fromMap(res);
      userData.setTransactions(userTransactions);
      state = AsyncValue.data(userData);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

final userProvider =
    StateNotifierProvider<UserNotifier, AsyncValue<UserModel>>((ref) {
  return UserNotifier()..initUserState();
});
