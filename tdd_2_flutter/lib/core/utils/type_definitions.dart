import 'package:dartz/dartz.dart';
import 'package:tdd_2_flutter/core/errors/failures.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;

typedef DataMap = Map<String, dynamic>;
