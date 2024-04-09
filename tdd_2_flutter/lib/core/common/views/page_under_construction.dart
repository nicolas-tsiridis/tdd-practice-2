import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tdd_2_flutter/core/common/widgets/gradient_background.dart';
import 'package:tdd_2_flutter/core/res/media_resources.dart';

class PageUnderConstruction extends StatelessWidget {
  const PageUnderConstruction({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: Center(
          child: Lottie.asset(MediaResources.carAnimation),
        ),
      ),
    );
  }
} //52:14
