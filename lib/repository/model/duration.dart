import 'package:cloud_firestore/cloud_firestore.dart';

class DurationModel {
  String? id;
  final String end;
  final String start;
  final int price;

  DurationModel({
    required this.end,
    required this.start,
    required this.price,
  });

  factory DurationModel.fromJson(DocumentSnapshot<Object?> json) {
    return DurationModel(
      end: json['end'],
      start: json['start'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'end': end,
      'start': start,
      'price': price,
    };
  }
}
