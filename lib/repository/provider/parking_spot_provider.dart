import 'dart:async';
import 'dart:convert';

import 'package:ez_parky/constants.dart';
import 'package:ez_parky/services/parking_gate_service.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ParkingSpotNotifier extends StateNotifier<AsyncValue<List<dynamic>>> {
  ParkingSpotNotifier() : super(const AsyncValue.loading());

  late StreamSubscription<DatabaseEvent> _onDataAddedSubscription;
  late List<Object?> _originalList = [];
  late List<dynamic> _parkingSpotData = [];

  void init() async {
    final box = await Hive.openBox(boxName);
    final parkingGate = box.get(ParkingGateService.sensorBoxName);
    final DatabaseReference ref = FirebaseDatabase.instance.ref("/Usonic1");
    print("parkingGate: $parkingGate");
    try {
      _onDataAddedSubscription = ref.onValue.listen((event) {
        print("event: ${jsonEncode(event.snapshot.value)}");
        _originalList = event.snapshot.value as List<Object?>;
        _parkingSpotData = _originalList.map((e) {
          return e as Map<dynamic, dynamic>;
        }).toList();
        state = AsyncValue.data(_parkingSpotData);
      });
    } catch (e) {
      print("errorss $e");
      rethrow;
    }
  }

  @override
  void dispose() {
    _onDataAddedSubscription.cancel();
    super.dispose();
  }
}

final parkingSpotProvider =
    StateNotifierProvider<ParkingSpotNotifier, AsyncValue<List<dynamic>>>(
        (ref) {
  return ParkingSpotNotifier()..init();
});
