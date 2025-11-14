import 'package:flutter/material.dart';

class CommonFilledButtonTheme extends StatelessWidget {
  final Widget child;

  const CommonFilledButtonTheme({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return FilledButtonTheme(
      data: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 8),
          visualDensity: VisualDensity.compact,
        ),
      ),
      child: child,
    );
  }
}
