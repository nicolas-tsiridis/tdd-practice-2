import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_2_flutter/src/on_boarding/domain/repos/on_boarding_repo.dart';
import 'package:tdd_2_flutter/src/on_boarding/domain/use_cases/check_if_user_is_first_timer.dart';

import 'on_boarding_repo.mock.dart';

void main() {
  late OnBoardingRepo repo;
  late CheckIfUserIsFirstTimer useCase;

  setUp(() {
    repo = MockOnBoardingRepo();
    useCase = CheckIfUserIsFirstTimer(repo);
  });

  test(
      'should call [OnBoardingRepo.checkIfUserIsFirstTimer] and return correct data',
      () async {
    when(() => repo.checkIfUserIsFirstTimer()).thenAnswer(
      (_) async => const Right(true),
    );

    final result = await useCase();
    expect(result, equals(const Right<dynamic, bool>(true)));
    verify(() => repo.checkIfUserIsFirstTimer()).called(1);
    verifyNoMoreInteractions(repo);
  });
}
