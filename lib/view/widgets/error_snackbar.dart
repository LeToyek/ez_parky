import 'package:flutter/material.dart';

Widget errorSnackBar(BuildContext context, String message) {
  return SnackBar(
    content: Text(message),
    backgroundColor: Colors.red,
    duration: const Duration(seconds: 3),
  );
}
