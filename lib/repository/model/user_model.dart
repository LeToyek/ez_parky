import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ez_parky/repository/model/wallet_model.dart';

class UserModel {
  final String email;
  final String name;
  final String imageUrl;
  WalletModel? wallet;

  UserModel({required this.email, required this.name, required this.imageUrl});

  factory UserModel.fromJson(DocumentSnapshot<Object?> json) {
    return UserModel(
        email: json['email'], name: json['name'], imageUrl: json['imageUrl']);
  }

  Map<String, dynamic> toJson() {
    return {"email": email, "name": name, "imageUrl": imageUrl};
  }
}
