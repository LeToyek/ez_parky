import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ez_parky/repository/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  static final currentUser = FirebaseAuth.instance.currentUser;
  static const userCollection = "user";
  static Future<void> initUserData() async {
    CollectionReference userRef =
        FirebaseFirestore.instance.collection(userCollection);

    userRef.doc(currentUser!.uid).set(UserModel(
            email: currentUser!.email!,
            name: currentUser!.displayName!,
            imageUrl: currentUser!.photoURL!)
        .toJson());
  }
}
