import 'package:flutter_riverpod/flutter_riverpod.dart';

class GlobalNotifier extends StateNotifier<bool> {
  GlobalNotifier() : super(false);

  void setIsSubmitting(bool isSubmitting) {
    state = isSubmitting;
  }
}

final globalProvider = StateNotifierProvider<GlobalNotifier, bool>(
  (ref) => GlobalNotifier(),
);
