import 'package:flutter/material.dart';

class EzScaffold extends StatelessWidget {
  const EzScaffold({
    super.key,
    required this.title,
    required this.ezBody,
  });
  final String title;
  final Widget ezBody;
  @override
  Widget build(BuildContext context) {
    var textThemeData = Theme.of(context).textTheme;
    var themeData = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            title,
          ),
        ),
        body: ezBody);
  }
}
