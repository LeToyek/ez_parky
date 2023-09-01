import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WalletService {
  final currentUser = FirebaseAuth.instance.currentUser;
  final walletRef = FirebaseFirestore.instance.collection('user');
  Future<void> getWallet() async {}
}
