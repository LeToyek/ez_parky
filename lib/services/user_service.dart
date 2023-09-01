import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ez_parky/repository/model/user_model.dart';
import 'package:ez_parky/repository/model/wallet_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  static final currentUser = FirebaseAuth.instance.currentUser;
  static const userCollection = "user";
  static Future<void> initUserData() async {
    CollectionReference userRef =
        FirebaseFirestore.instance.collection(userCollection);

    try {
      final user = await userRef.doc(currentUser!.uid).get();
      print('user ${user.exists}');
      final timeNow = DateTime.now().toString();
      if (!user.exists) {
        userRef.doc(currentUser!.uid).set(UserModel(
                email: currentUser!.email!,
                name: currentUser!.displayName!,
                imageUrl: currentUser!.photoURL!,
                wallet: WalletModel(
                    value: 0, createdAt: timeNow, updateAt: timeNow),
                createdAt: timeNow,
                updatedAt: timeNow)
            .toMap());
      }
    } catch (e) {
      print("error : $e");
    }
  }
}
