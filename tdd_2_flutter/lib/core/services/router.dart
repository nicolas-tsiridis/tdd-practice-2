import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdd_2_flutter/core/common/views/page_under_construction.dart';
import 'package:tdd_2_flutter/core/services/injection_container.dart';
import 'package:tdd_2_flutter/src/on_boarding/presentation/cubit/cubit/on_boarding_cubit.dart';
import 'package:tdd_2_flutter/src/on_boarding/presentation/views/on_boarding_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  debugPrint('settings: ${settings.name}');
  switch (settings.name) {
    case OnBoardingScreen.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (context) => sl<OnBoardingCubit>(),
          child: const OnBoardingScreen(),
        ),
        settings: settings,
      );
    default:
      return _pageBuilder(
        (_) => const PageUnderConstruction(),
        settings: settings, //3:36:00
      );
  }
}

PageRouteBuilder<dynamic> _pageBuilder(
  Widget Function(BuildContext) page, {
  required RouteSettings settings,
}) {
  return PageRouteBuilder(
    settings: settings,
    transitionsBuilder: (_, animation, __, child) =>
        FadeTransition(opacity: animation, child: child),
    pageBuilder: (context, _, __) => page(context),
  );
}
