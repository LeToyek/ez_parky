import 'package:ez_parky/constants.dart';
import 'package:ez_parky/repository/model/parking_gate.dart';
import 'package:ez_parky/services/parking_gate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ScannerNotifier extends StateNotifier<AsyncValue<ParkingGate>> {
  ScannerNotifier() : super(const AsyncValue.loading());

  Future<void> getParkingGate(String id) async {
    try {
      const AsyncValue.loading();
      final parkingGate = await ParkingGateService.getParkingGate(id);
      Hive.box(boxName)
          .put(ParkingGateService.sensorBoxName, parkingGate.sensorID);
      state = AsyncValue.data(parkingGate);
    } on FirebaseException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}

final scannerProvider =
    StateNotifierProvider<ScannerNotifier, AsyncValue<ParkingGate>>((ref) {
  return ScannerNotifier();
});
