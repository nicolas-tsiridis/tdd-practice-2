import 'package:tdd_2_flutter/core/use_cases/use_cases.dart';
import 'package:tdd_2_flutter/core/utils/type_definitions.dart';
import 'package:tdd_2_flutter/src/on_boarding/domain/repos/on_boarding_repo.dart';

class CheckIfUserIsFirstTimer extends UseCaseWithoutParams<bool> {
  const CheckIfUserIsFirstTimer(this._repo);
  final OnBoardingRepo _repo;

  @override
  ResultFuture<bool> call() => _repo.checkIfUserIsFirstTimer();
}
