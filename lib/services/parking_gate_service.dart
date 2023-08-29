import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ez_parky/repository/model/parking_gate.dart';
import 'package:ez_parky/services/duration_service.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ParkingGateService {
  static CollectionReference parkingGate =
      FirebaseFirestore.instance.collection('park_gate');
  static const String sensorBoxName = 'parking_gate_sensor_id';

  static Future<ParkingGate> getParkingGate(String id) async {
    try {
      final res = await parkingGate.doc(id).get();
      final data = ParkingGate.fromJson(res);
      data.id = id;

      final resDuration =
          await DurationService.createDurationDoc(id, data.price);
      final box = await Hive.openBox(sensorBoxName);
      await box.put(sensorBoxName, data.sensorID);
      await box.put(DurationService.durationBox, resDuration.id);
      return data;
    } catch (e) {
      rethrow;
    }
  }
}
