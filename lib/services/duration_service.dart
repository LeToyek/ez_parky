import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ez_parky/constants.dart';
import 'package:ez_parky/repository/model/duration.dart';
import 'package:ez_parky/services/parking_gate_service.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DurationService {
  static CollectionReference getDuartionServiceCollectionRef(String id) {
    return ParkingGateService.parkingGate.doc(id).collection('responses');
  }

  static const String durationBox = 'duration_id';
  // static const String sensorBoxName = 'parking_gate_sensor_id';

  static Future<DurationModel> getDuration(String id) async {
    try {
      final durationID = Hive.box(boxName).get(durationBox);
      final res =
          await getDuartionServiceCollectionRef(id).doc(durationID).get();
      final data = DurationModel.fromJson(res);
      data.id = id;
      // final box = await Hive.openBox(ParkingGateService.sensorBoxName);

      return data;
    } catch (e) {
      rethrow;
    }
  }

  static Future<DocumentReference> createDurationDoc(
      String id, int price) async {
    try {
      DurationModel durationModel = DurationModel(
          start: DateTime.now().toString(),
          end: DateTime.now().toString(),
          price: price);
      final res =
          await getDuartionServiceCollectionRef(id).add(durationModel.toJson());
      return res;
    } catch (e) {
      rethrow;
    }
  }
}
