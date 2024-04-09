//cSpell:ignore mocktail dartz
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_2_flutter/core/errors/failures.dart';
import 'package:tdd_2_flutter/src/on_boarding/domain/use_cases/cache_first_timer.dart';
import 'package:tdd_2_flutter/src/on_boarding/domain/use_cases/check_if_user_is_first_timer.dart';
import 'package:tdd_2_flutter/src/on_boarding/presentation/cubit/cubit/on_boarding_cubit.dart';

class MockCacheFirstTimer extends Mock implements CacheFirstTimer {}

class MockCheckIfUserIsFirstTimer extends Mock
    implements CheckIfUserIsFirstTimer {}

void main() {
  late CacheFirstTimer cacheFirstTimer;
  late CheckIfUserIsFirstTimer checkIfUserIsFirstTimer;
  late OnBoardingCubit onBoardingCubit;

  setUp(() {
    cacheFirstTimer = MockCacheFirstTimer();
    checkIfUserIsFirstTimer = MockCheckIfUserIsFirstTimer();
    onBoardingCubit = OnBoardingCubit(
      cacheFirstTimer: cacheFirstTimer,
      checkIfUserIsFirstTimer: checkIfUserIsFirstTimer,
    );
  });

  const tFailure = CacheFailure(
    message: 'Insufficient Permissions',
    statusCode: 4032,
  );

  test('initial state should be [OnBoardingInitial]', () async {
    expect(onBoardingCubit.state, const OnBoardingInitial());
  });

  group('cacheFirstTimer', () {
    blocTest<OnBoardingCubit, OnBoardingState>(
      'should emit [CachingFirstTimer, OnBoardingStatus] when successful',
      build: () {
        when(() => cacheFirstTimer())
            .thenAnswer((invocation) async => const Right(null));
        return onBoardingCubit;
      },
      act: (cubit) => cubit.cacheFirstTimer(),
      expect: () => const [CachingFirstTimer(), UserCached()],
      verify: (_) {
        verify(() => cacheFirstTimer()).called(1);
        verifyNoMoreInteractions(cacheFirstTimer);
      },
    );
    blocTest<OnBoardingCubit, OnBoardingState>(
      'should emit a [CachingFirstTimer, OnBoardingError] when unsuccessful',
      build: () {
        when(() => cacheFirstTimer()).thenAnswer(
          (invocation) async => const Left(tFailure),
        );
        return onBoardingCubit;
      },
      act: (cubit) => cubit.cacheFirstTimer(),
      expect: () =>
          [const CachingFirstTimer(), OnBoardingError(tFailure.errorMessage)],
      verify: (_) {
        verify(() => cacheFirstTimer()).called(1);
        verifyNoMoreInteractions(cacheFirstTimer);
      },
    );
  });

  group('checkIfUserIsFirstTimer', () {
    blocTest<OnBoardingCubit, OnBoardingState>(
      'should emit [CheckingIfUserIsFirstTimer, OnBoardingStatus] '
      'when successful',
      build: () {
        when(() => checkIfUserIsFirstTimer())
            .thenAnswer((_) async => const Right(false));
        return onBoardingCubit;
      },
      act: (cubit) => cubit.checkIfUserIsFirstTimer(),
      expect: () => const [
        CheckingIfUserIsFirstTimer(),
        OnBoardingStatus(isFirstTimer: false),
      ],
      verify: (_) {
        verify(() => checkIfUserIsFirstTimer()).called(1);
        verifyNoMoreInteractions(checkIfUserIsFirstTimer);
      },
    );

    blocTest<OnBoardingCubit, OnBoardingState>(
      'should emit [CheckingIfUserIsFirstTimer, OnBoardingError] '
      'when unsuccessful',
      build: () {
        when(() => checkIfUserIsFirstTimer())
            .thenAnswer((_) async => const Left(tFailure));
        return onBoardingCubit;
      },
      act: (cubit) => cubit.checkIfUserIsFirstTimer(),
      expect: () => const [
        CheckingIfUserIsFirstTimer(),
        OnBoardingStatus(isFirstTimer: true),
      ],
      verify: (_) {
        verify(() => checkIfUserIsFirstTimer()).called(1);
        verifyNoMoreInteractions(checkIfUserIsFirstTimer);
      },
    );
  });
}
