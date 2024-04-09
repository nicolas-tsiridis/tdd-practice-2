import 'package:equatable/equatable.dart';
import 'package:tdd_2_flutter/core/errors/exceptions.dart';

abstract class Failure extends Equatable {
  const Failure({
    required this.message,
    required this.statusCode,
  });

  final String message;
  final int statusCode;
  String get errorMessage => '$statusCode Error: $message';

  @override
  List<Object> get props => [message, statusCode];
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message, required super.statusCode});

  ServerFailure.fromException(ApiException exception)
      : this(message: exception.message, statusCode: exception.statusCode);
}

class CacheFailure extends Failure {
  const CacheFailure({required super.message, required super.statusCode});

  CacheFailure.fromException(ApiException exception)
      : this(message: exception.message, statusCode: exception.statusCode);
}
