import 'package:flutter/material.dart';
import 'package:tdd_2_flutter/core/extensions/context_extension.dart';
import 'package:tdd_2_flutter/src/on_boarding/domain/entities/page_content.dart';

class OnBoardingBody extends StatelessWidget {
  const OnBoardingBody({required this.pageContent, super.key});

  final PageContent pageContent;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          pageContent.image,
          height: context.height * 0.4,
        )
      ],
    );
  }
}
