//cSpell:ignore dartz mocktail
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_2_flutter/core/errors/exceptions.dart';
import 'package:tdd_2_flutter/core/errors/failures.dart';
import 'package:tdd_2_flutter/src/on_boarding/data/data_sources/on_boarding_local_data_source.dart';
import 'package:tdd_2_flutter/src/on_boarding/data/repositories/on_boarding_repo_impl.dart';

class MockOnBoardingLocalDataSource extends Mock
    implements OnBoardingLocalDataSource {}

void main() {
  late OnBoardingLocalDataSource localDataSource;
  late OnBoardingRepoImpl repoImpl;

  setUp(() {
    localDataSource = MockOnBoardingLocalDataSource();
    repoImpl = OnBoardingRepoImpl(localDataSource);
  });

  group('cashFirstTimer', () {
    test('should return [Right<Null>] when call to localSources is successful',
        () async {
      when(() => localDataSource.cacheFirstTimer())
          .thenAnswer((_) async => Future.value);
      final result = await repoImpl.cacheFirstTimer();
      expect(result, equals(const Right<dynamic, void>(null)));
      verify(localDataSource.cacheFirstTimer).called(1);
      verifyNoMoreInteractions(localDataSource);
    });

    test(
        'should return a [cacheFailure] when call to [localSource] is unsuccessful',
        () async {
      when(() => localDataSource.cacheFirstTimer())
          .thenThrow(const CacheException(message: 'Something went wrong'));

      final result = await repoImpl.cacheFirstTimer();
      expect(
        result,
        equals(
          const Left<CacheFailure, dynamic>(
            CacheFailure(message: 'Something went wrong', statusCode: 500),
          ),
        ),
      );
      verify(localDataSource.cacheFirstTimer).called(1);
      verifyNoMoreInteractions(localDataSource);
    });
  });

  group('checkIfUserIsFirstTimer', () {
    test(
      'should return [Right<bool>] when datasource is successful',
      () async {
        when(() => localDataSource.checkIfUserIsFirstTimer())
            .thenAnswer((_) async => Future.value(true));
        final result = await repoImpl.checkIfUserIsFirstTimer();
        expect(result, equals(const Right<dynamic, bool>(true)));
        verify(() => localDataSource.checkIfUserIsFirstTimer()).called(1);
        verifyNoMoreInteractions(localDataSource);
      },
    );
  });
}
