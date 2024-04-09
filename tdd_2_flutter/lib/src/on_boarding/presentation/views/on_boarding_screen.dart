import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdd_2_flutter/core/common/views/loading_view.dart';
import 'package:tdd_2_flutter/core/common/widgets/gradient_background.dart';
import 'package:tdd_2_flutter/src/on_boarding/domain/entities/page_content.dart';
import 'package:tdd_2_flutter/src/on_boarding/domain/use_cases/check_if_user_is_first_timer.dart';
import 'package:tdd_2_flutter/src/on_boarding/presentation/cubit/cubit/on_boarding_cubit.dart';
import 'package:tdd_2_flutter/src/on_boarding/presentation/widgets/on_boarding_body.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});
  static const routeName = '/';

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  void initState() {
    super.initState();
    context.read<OnBoardingCubit>().checkIfUserIsFirstTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<OnBoardingCubit, OnBoardingState>(
        listener: (context, state) {
          if (state is OnBoardingStatus && !state.isFirstTimer) {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (state is UserCached) {
            //TODO (user cached handler): push to appropriate screen
          }
        },
        builder: (context, state) {
          if (state is CheckIfUserIsFirstTimer || state is CachingFirstTimer) {
            return const LoadingView();
          }
          return GradientBackground(
            child: PageView(
              children: [
                OnBoardingBody(pageContent: PageContent.first()),
                OnBoardingBody(pageContent: PageContent.second()),
                OnBoardingBody(pageContent: PageContent.third()),
              ],
            ),
          );
        },
      ),
    );
  }
}
