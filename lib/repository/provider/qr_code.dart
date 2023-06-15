import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

class QrCodeNotifier extends StateNotifier<AsyncValue<String>> {
  late Timer _timer;
  final int intervalTime = 3;
  QrCodeNotifier() : super(const AsyncValue.loading()) {
    setQrData();
  }

  void setQrData() {
    _timer = Timer.periodic(Duration(seconds: intervalTime), (_) {
      final secret = const Uuid().v4();
      state = AsyncValue.data(secret);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}

// ignore: non_constant_identifier_names
final QrCodeProvider =
    StateNotifierProvider<QrCodeNotifier, AsyncValue<String>>((ref) {
  return QrCodeNotifier();
});
