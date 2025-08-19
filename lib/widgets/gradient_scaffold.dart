import 'package:flutter/material.dart';

class GradientScaffold extends StatelessWidget {
  final List<Color> colors;
  final Widget child;

  const GradientScaffold({
    super.key,
    required this.colors,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(child: child),
      ),
    );
  }
}
