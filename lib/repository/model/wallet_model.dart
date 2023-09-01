import 'dart:convert';

class WalletModel {
  final int value;
  String? createdAt;
  String? updateAt;

  WalletModel({
    required this.value,
    this.createdAt,
    this.updateAt,
  });

  WalletModel copyWith({
    int? value,
    String? createdAt,
    String? updateAt,
  }) {
    return WalletModel(
      value: this.value,
      createdAt: createdAt ?? this.createdAt,
      updateAt: updateAt ?? this.updateAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'value': value,
      'createdAt': createdAt,
      'updateAt': updateAt,
    };
  }

  factory WalletModel.fromMap(Map<String, dynamic> map) {
    return WalletModel(
      value: map['value']?.toInt() ?? 0,
      createdAt: map['createdAt'] ?? '',
      updateAt: map['updateAt'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory WalletModel.fromJson(String source) =>
      WalletModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'WalletModel(value: $value, createdAt: $createdAt, updateAt: $updateAt)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WalletModel &&
        other.value == value &&
        other.createdAt == createdAt &&
        other.updateAt == updateAt;
  }

  @override
  int get hashCode => value.hashCode ^ createdAt.hashCode ^ updateAt.hashCode;
}
