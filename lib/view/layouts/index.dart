import 'package:ez_parky/view/layouts/drawer.dart';
import 'package:flutter/material.dart';

class EzScaffold extends StatelessWidget {
  const EzScaffold({super.key, required this.ezBody});
  final Widget ezBody;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('ez parky'),
        ),
        drawer: ezDrawer,
        body: ezBody);
  }
}
