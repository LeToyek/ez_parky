import 'package:flutter/material.dart';

class EzScaffold extends StatelessWidget {
  const EzScaffold({
    super.key,
    required this.title,
    required this.isDark,
    required this.ezBody,
  });
  final bool isDark;
  final String title;
  final Widget ezBody;
  @override
  Widget build(BuildContext context) {
    var textThemeData = Theme.of(context).textTheme;
    var themeData = Theme.of(context);
    return Scaffold(
        appBar: isDark
            ? AppBar(
                title: Text(
                  title,
                ),
              )
            : AppBar(
                title: Text(
                  title,
                  style: textThemeData.displayLarge,
                ),
                backgroundColor: Colors.white,
                elevation: 1,
              ),
        body: ezBody);
  }
}
