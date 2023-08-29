import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ez_parky/repository/model/parking_gate.dart';

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
}
