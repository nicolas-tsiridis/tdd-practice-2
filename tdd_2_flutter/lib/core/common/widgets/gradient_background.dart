import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  const GradientBackground({this.child, super.key});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white,
            Colors.grey,
          ],
        ),
      ),
      child: SafeArea(
        child: (child != null) ? child! : Container(),
      ),
    );
  }
}
