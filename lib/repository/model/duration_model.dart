import 'package:cloud_firestore/cloud_firestore.dart';

class DurationModel {
  String? id;
  String end;
  final String start;
  int price;
  String? createdAt;
  String? updateAt;

  DurationModel(
      {required this.end,
      required this.start,
      required this.price,
      this.createdAt,
      this.updateAt});

  factory DurationModel.fromJson(DocumentSnapshot<Object?> json) {
    return DurationModel(
        end: json['end'],
        start: json['start'],
        price: json['price'],
        createdAt: json['created_at'],
        updateAt: json['updated_at']);
  }

  Map<String, dynamic> toJson() {
    return {
      'end': end,
      'start': start,
      'price': price,
      'created_at': createdAt,
      'updated_at': updateAt
    };
  }
}
