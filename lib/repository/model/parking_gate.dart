import 'package:cloud_firestore/cloud_firestore.dart';

class ParkingGate {
  String? id;
  final String location;
  final int price;
  final int capacity;
  final String sensorID;

  ParkingGate({
    required this.location,
    required this.price,
    required this.capacity,
    required this.sensorID,
  });

  factory ParkingGate.fromJson(DocumentSnapshot json) {
    return ParkingGate(
      location: json['location'],
      price: json['price'],
      capacity: json['capacity'],
      sensorID: json['sensors_id'],
    );
  }
}
