import 'package:dartz/dartz.dart';
import 'package:tdd_2_flutter/core/errors/exceptions.dart';
import 'package:tdd_2_flutter/core/errors/failures.dart';
import 'package:tdd_2_flutter/core/utils/type_definitions.dart';
import 'package:tdd_2_flutter/src/on_boarding/data/data_sources/on_boarding_local_data_source.dart';
import 'package:tdd_2_flutter/src/on_boarding/domain/repos/on_boarding_repo.dart';

class OnBoardingRepoImpl implements OnBoardingRepo {
  const OnBoardingRepoImpl(this._localDataSource);

  final OnBoardingLocalDataSource _localDataSource;

  @override
  ResultFuture<void> cacheFirstTimer() async {
    try {
      await _localDataSource.cacheFirstTimer();
      return const Right(null);
    } on CacheException catch (e) {
      //
      return Left(CacheFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<bool> checkIfUserIsFirstTimer() async {
    try {
      final result = await _localDataSource.checkIfUserIsFirstTimer();
      return Right(result);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
