import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ez_parky/repository/model/parking_gate_model.dart';

class ParkingGateService {
  static CollectionReference parkingGate =
      FirebaseFirestore.instance.collection('park_gate');
  static const String sensorBoxName = 'parking_gate_sensor_id';
  static const String gateBoxName = 'parking_gate_id';

  static Future<ParkingGate> getParkingGate(String id) async {
    try {
      final res = await parkingGate.doc(id).get();
      final data = ParkingGate.fromJson(res);
      data.id = id;
      return data;
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<ParkingGate>> getAllParkingGates() async {
    try {
      final res = await parkingGate.get();
      final data = res.docs.map((e) {
        print("gates ${jsonEncode(e.data())}");
        final parkingGate = ParkingGate.fromJson(e);
        parkingGate.id = e.id;
        return parkingGate;
      }).toList();
      return data;
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> increaseGateIncome(String id, int inputValue) async {
    try {
      final res = parkingGate.doc(id);
      await res.update({"income": FieldValue.increment(inputValue)});
    } catch (e) {
      rethrow;
    }
  }
}
