import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  final int value;
  String? createdAt;
  String? updatedAt;
  TransactionModel({
    required this.value,
    this.createdAt,
    this.updatedAt,
  });

  TransactionModel copyWith({
    int? value,
    String? createdAt,
    String? updatedAt,
  }) {
    return TransactionModel(
      value: value ?? this.value,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'value': value,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory TransactionModel.fromMap(DocumentSnapshot map) {
    return TransactionModel(
      value: map['value']?.toInt() ?? 0,
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionModel.fromJson(String source) =>
      TransactionModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'TransactionModel(value: $value, createdAt: $createdAt, updatedAt: $updatedAt)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TransactionModel &&
        other.value == value &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode => value.hashCode ^ createdAt.hashCode ^ updatedAt.hashCode;
}
