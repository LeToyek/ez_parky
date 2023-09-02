import 'dart:convert';

class TransactionModel {
  final int value;
  String? createdAt;
  String? updatedAt;
  String? logType;
  String? logMessage;
  TransactionModel({
    required this.value,
    this.createdAt,
    this.updatedAt,
    this.logType,
    this.logMessage,
  });

  TransactionModel copyWith({
    int? value,
    String? createdAt,
    String? updatedAt,
    String? logType,
    String? logMessage,
  }) {
    return TransactionModel(
      value: value ?? this.value,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      logType: logType ?? this.logType,
      logMessage: logMessage ?? this.logMessage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'value': value,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'logType': logType,
      'logMessage': logMessage,
    };
  }

  String toJson() => json.encode(toMap());

  factory TransactionModel.fromJson(String source) =>
      TransactionModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TransactionModel(value: $value, createdAt: $createdAt, updatedAt: $updatedAt, logType: $logType, logMessage: $logMessage)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TransactionModel &&
        other.value == value &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.logType == logType &&
        other.logMessage == logMessage;
  }

  @override
  int get hashCode {
    return value.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        logType.hashCode ^
        logMessage.hashCode;
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      value: map['value']?.toInt() ?? 0,
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
      logType: map['logType'],
      logMessage: map['logMessage'],
    );
  }
}
