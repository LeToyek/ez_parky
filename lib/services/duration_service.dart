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
      final box = await Hive.openBox(boxName);
      final durationID = await box.get(durationBox);
      final res =
          await getDuartionServiceCollectionRef(id).doc(durationID).get();
      final data = DurationModel.fromJson(res);
      data.id = id;

      return data;
    } catch (e) {
      print("error $e");
      rethrow;
    }
  }

  static Future<DocumentReference> createDurationDoc(
      String id, int price) async {
    try {
      DurationModel durationModel = DurationModel(
          start: DateTime.now().toString(), end: "", price: price);
      final res =
          await getDuartionServiceCollectionRef(id).add(durationModel.toJson());

      final box = await Hive.openBox(boxName);
      box.put(durationBox, res.id);

      return res;
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> setDurationDoc(String gateID, String durationID) async {
    try {
      final res = getDuartionServiceCollectionRef(gateID).doc(durationID);
      final updated = await res.update({
        'end': DateTime.now().toString(),
      });
    } catch (e) {
      rethrow;
    }
  }

  static int calculateHour(String time) {
    final timeStart = DateTime.parse(time);
    final timeNow = DateTime.now();

    Duration difference = timeNow.difference(timeStart);

    int hour = difference.inHours;
    if (hour == 0) {
      hour = 1;
    }

    return hour;
  }
}
