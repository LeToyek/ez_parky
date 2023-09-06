import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ez_parky/repository/model/transaction_model.dart';
import 'package:ez_parky/repository/model/wallet_model.dart';

class UserModel {
  final String email;
  final String name;
  final String imageUrl;
  final WalletModel wallet;
  List<TransactionModel>? transactions;
  String? createdAt;
  String? updatedAt;

  UserModel({
    required this.email,
    required this.name,
    required this.imageUrl,
    required this.wallet,
    this.createdAt,
    this.updatedAt,
    this.transactions,
  });

  UserModel copyWith({
    String? email,
    String? name,
    String? imageUrl,
    WalletModel? wallet,
    String? createdAt,
    String? updatedAt,
  }) {
    return UserModel(
      email: email ?? this.email,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      wallet: wallet ?? this.wallet,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'imageUrl': imageUrl,
      'wallet': wallet.toMap(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory UserModel.fromMap(DocumentSnapshot<Object?> map) {
    return UserModel(
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      wallet: WalletModel.fromMap(map['wallet']),
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(email: $email, name: $name, imageUrl: $imageUrl, wallet: $wallet, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.email == email &&
        other.name == name &&
        other.imageUrl == imageUrl &&
        other.wallet == wallet &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return email.hashCode ^
        name.hashCode ^
        imageUrl.hashCode ^
        wallet.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }

  void setTransactions(List<TransactionModel> transactions) {
    this.transactions = transactions;
  }
}
