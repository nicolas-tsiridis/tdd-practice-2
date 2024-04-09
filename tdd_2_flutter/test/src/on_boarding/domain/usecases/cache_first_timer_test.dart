//cSpell:ignore dartz mocktail
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_2_flutter/core/errors/failures.dart';
import 'package:tdd_2_flutter/src/on_boarding/domain/repos/on_boarding_repo.dart';
import 'package:tdd_2_flutter/src/on_boarding/domain/use_cases/cache_first_timer.dart';

import 'on_boarding_repo.mock.dart';

void main() {
  late OnBoardingRepo repo;
  late CacheFirstTimer useCase;
  late ServerFailure tServerFailure;

  setUp(() {
    repo = MockOnBoardingRepo();
    useCase = CacheFirstTimer(repo);
    tServerFailure =
        const ServerFailure(message: 'unknown error occurred', statusCode: 500);
  });

  test('should call [onBoardingRepo.cacheFirstTimer] and return correct data',
      () async {
    when(() => repo.cacheFirstTimer()).thenAnswer(
      (_) async => const Left(
        ServerFailure(message: 'unknown error occurred', statusCode: 500),
      ),
    );

    final result = await useCase();
    expect(result, equals(Left<Failure, void>(tServerFailure)));
    verify(() => repo.cacheFirstTimer()).called(1);
    verifyNoMoreInteractions(repo);
  });
}
