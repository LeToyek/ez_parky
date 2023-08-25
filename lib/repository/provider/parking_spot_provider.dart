import 'dart:async';

import 'package:ez_parky/constants.dart';
import 'package:ez_parky/services/parking_gate.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ParkingSpotNotifier extends StateNotifier<AsyncValue<List<dynamic>>> {
  ParkingSpotNotifier() : super(const AsyncValue.loading());

  final DatabaseReference ref = FirebaseDatabase.instance
      .ref(Hive.box(boxName).get(ParkingGateService.sensorBoxName));
  late StreamSubscription<DatabaseEvent> _onDataAddedSubscription;
  late List<Object?> _originalList = [];
  late List<dynamic> _parkingSpotData = [];

  void init() {
    _onDataAddedSubscription = ref.onValue.listen((event) {
      _originalList = event.snapshot.value as List<Object?>;
      _parkingSpotData = _originalList.map((e) {
        return e as Map<dynamic, dynamic>;
      }).toList();
      state = AsyncValue.data(_parkingSpotData);
    });
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
