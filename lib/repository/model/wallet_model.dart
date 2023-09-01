import 'package:cloud_firestore/cloud_firestore.dart';

class WalletModel {
  int value;
  String createdAt;
  String updateAt;

  WalletModel(
      {required this.value, required this.createdAt, required this.updateAt});

  factory WalletModel.fromJson(DocumentSnapshot<Object?> json) {
    return WalletModel(
        value: json['value'],
        createdAt: json['created_at'],
        updateAt: json['updated_at']);
  }

  Map<String, dynamic> toJson() {
    return {'value': value, 'created_at': createdAt, 'updated_at': updateAt};
  }
}
