import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_app_template/app/config/app_config.dart';
import 'package:flutter_app_template/app/config/feature_flags.dart';

abstract final class ApiClientDefaults {
  static const connectTimeout = Duration(seconds: 10);
  static const receiveTimeout = Duration(seconds: 10);
  static const sendTimeout = Duration(seconds: 10);
}

typedef CommonHeadersBuilder = Map<String, String> Function(AppConfig config);

typedef ApiErrorMapper = DioException Function(DioException error);

final commonHeadersProvider = Provider<CommonHeadersBuilder>(
  (ref) =>
      (config) => const {'Accept': 'application/json'},
);

final authTokenProvider = Provider<String?>((ref) => null);

final apiErrorMapperProvider = Provider<ApiErrorMapper>(
  (ref) =>
      (error) => error,
);

final dioProvider = Provider<Dio>((ref) {
  final config = ref.watch(appConfigProvider);
  final buildCommonHeaders = ref.watch(commonHeadersProvider);
  final authToken = ref.watch(authTokenProvider);
  final mapError = ref.watch(apiErrorMapperProvider);
  final featureFlags = ref.watch(featureFlagsProvider);

  final dio = Dio(
    BaseOptions(
      baseUrl: config.apiBaseUrl,
      connectTimeout: ApiClientDefaults.connectTimeout,
      receiveTimeout: ApiClientDefaults.receiveTimeout,
      sendTimeout: ApiClientDefaults.sendTimeout,
      headers: buildCommonHeaders(config),
    ),
  );

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        final token = authToken?.trim();
        if (token != null && token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
      },
      onError: (error, handler) => handler.reject(mapError(error)),
    ),
  );

  if (featureFlags.isNetworkLoggingAvailable(config)) {
    dio.interceptors.add(
      LogInterceptor(logPrint: (object) => debugPrint('$object')),
    );
  }

  return dio;
});
