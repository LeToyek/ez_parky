import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WalletService {
  final currentUser = FirebaseAuth.instance.currentUser;
  Future<void> getWallet() async {
    // CollectionReference walletRef = FirebaseFirestore.instance.collection(collectionPath)
  }
}
