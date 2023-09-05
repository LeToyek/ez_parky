import 'package:ez_parky/repository/model/parking_gate_model.dart';
import 'package:ez_parky/services/parking_gate_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ParkingLocationNotifier
    extends StateNotifier<AsyncValue<List<ParkingGate>>> {
  ParkingLocationNotifier() : super(const AsyncValue.loading());

  Future<void> init() async {
    try {
      state = const AsyncValue.loading();
      final data = await ParkingGateService.getAllParkingGates();
      state = AsyncValue.data(data);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

final parkingLocationProvider = StateNotifierProvider<ParkingLocationNotifier,
    AsyncValue<List<ParkingGate>>>((ref) {
  return ParkingLocationNotifier()..init();
});
