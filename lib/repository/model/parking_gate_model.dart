import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ez_parky/repository/model/duration_model.dart';

class ParkingGate {
  String? id;
  final String location;
  final int price;
  final int capacity;
  final String sensorID;
  final double latitude;
  final double longitude;
  DurationModel? duration;

  ParkingGate(
      {required this.location,
      required this.price,
      required this.capacity,
      required this.sensorID,
      this.duration,
      required this.latitude,
      required this.longitude});

  factory ParkingGate.fromJson(DocumentSnapshot json) {
    return ParkingGate(
      location: json['location'],
      price: json['price'],
      capacity: json['capacity'],
      sensorID: json['sensors_id'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}
