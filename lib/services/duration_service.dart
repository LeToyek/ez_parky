import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ez_parky/constants.dart';
import 'package:ez_parky/repository/model/duration_model.dart';
import 'package:ez_parky/repository/model/parking_gate_model.dart';
import 'package:ez_parky/services/parking_gate_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DurationService {
  static CollectionReference getDuartionServiceCollectionRef(String id) {
    final userID = FirebaseAuth.instance.currentUser;
    return ParkingGateService.parkingGate
        .doc(id)
        .collection('responses')
        .doc(userID!.uid)
        .collection('durations');
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
      data.id = durationID;

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

  static Future<void> setFinalResponses(ParkingGate gate, int price) async {
    try {
      print("gate.id := ${gate.id} | gate.duration.id := ${gate.duration!.id}");
      final res =
          getDuartionServiceCollectionRef(gate.id!).doc(gate.duration!.id);
      final updated =
          await res.update({'end': DateTime.now().toString(), 'price': price});
    } catch (e) {
      rethrow;
    }
  }

  static int calculateHour({required time, String? comparator}) {
    final timeStart = DateTime.parse(time);
    final realComparator =
        comparator == null ? DateTime.now() : DateTime.parse(comparator);

    Duration difference = realComparator.difference(timeStart);

    int hour = difference.inHours;
    if (hour == 0) {
      hour = 1;
    }

    return hour;
  }

  static Future<void> clearDurationCache() async {
    final box = await Hive.openBox(boxName);
    await box.put(durationBox, null);
    final res = await box.get(durationBox);
    print("duration box := $res");
  }
}
