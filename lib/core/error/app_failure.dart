import 'package:flutter_app_template/core/error/app_exception.dart';

class AppFailure {
  const AppFailure({
    required this.message,
    this.code,
    this.cause,
    this.isRecoverable = true,
  });

  factory AppFailure.fromException(
    Object error, {
    String fallbackMessage = 'Something went wrong.',
  }) {
    if (error is AppException) {
      return AppFailure(
        message: error.message,
        code: error.code,
        cause: error.cause ?? error,
      );
    }

    return AppFailure(message: fallbackMessage, cause: error);
  }

  final String message;
  final String? code;
  final Object? cause;
  final bool isRecoverable;

  @override
  String toString() => code == null ? message : '$code: $message';
}
