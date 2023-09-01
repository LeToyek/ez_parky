import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ez_parky/repository/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserNotifier extends StateNotifier<AsyncValue<UserModel>> {
  UserNotifier() : super(const AsyncValue.loading());

  CollectionReference userRef = FirebaseFirestore.instance.collection('user');

  Future<void> initUserState() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      state = const AsyncValue.loading();
      final userData = await userRef.doc(user!.uid).get();
      state = AsyncValue.data(UserModel.fromMap(userData));
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

final userProvider =
    StateNotifierProvider<UserNotifier, AsyncValue<UserModel>>((ref) {
  return UserNotifier();
});
