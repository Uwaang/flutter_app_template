import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_app_template/core/error/app_exception.dart';
import 'package:flutter_app_template/core/error/app_failure.dart';
import 'package:flutter_app_template/core/error/result.dart';

void main() {
  test('Result.when handles success and failure values', () {
    const success = Success<int>(7);
    const failure = Failure<int>(AppFailure(message: 'Nope'));

    expect(success.when(success: (value) => value * 2, failure: (_) => 0), 14);
    expect(
      failure.when(
        success: (value) => '$value',
        failure: (error) => error.message,
      ),
      'Nope',
    );
  });

  test('AppFailure maps AppException into a user-facing failure', () {
    const exception = AppException('Network unavailable', code: 'network');

    final failure = AppFailure.fromException(exception);

    expect(failure.message, 'Network unavailable');
    expect(failure.code, 'network');
    expect(failure.cause, exception);
  });
}
