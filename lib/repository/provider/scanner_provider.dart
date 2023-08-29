import 'package:ez_parky/constants.dart';
import 'package:ez_parky/repository/model/parking_gate.dart';
import 'package:ez_parky/services/parking_gate_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ScannerNotifier extends StateNotifier<AsyncValue<ParkingGate>> {
  late ParkingGate parkingGateData;
  ScannerNotifier() : super(const AsyncValue.loading());

  Future<ParkingGate> getParkingGate(String id) async {
    try {
      const AsyncValue.loading();
      final parkingGate = await ParkingGateService.getParkingGate(id);
      Hive.box(boxName).put(ParkingGateService.gateBoxName, parkingGate.id);
      state = AsyncValue.data(parkingGate);
      parkingGateData = parkingGate;
      return parkingGate;
    } on FirebaseException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> getGateIDFromLocal() async {
    try {
      final gateID = Hive.box(boxName).get(ParkingGateService.gateBoxName);

      return gateID;
    } catch (e) {
      rethrow;
    }
  }
}

final scannerProvider =
    StateNotifierProvider<ScannerNotifier, AsyncValue<ParkingGate>>((ref) {
  return ScannerNotifier();
});
