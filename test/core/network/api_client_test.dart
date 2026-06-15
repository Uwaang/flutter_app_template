import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_app_template/app/config/app_config.dart';
import 'package:flutter_app_template/app/config/app_environment.dart';
import 'package:flutter_app_template/core/network/api_client.dart';

void main() {
  const config = AppConfig(
    appName: 'Client App',
    brandName: 'Client Brand',
    applicationId: 'com.example.client',
    apiBaseUrl: 'https://api.client.example',
    environment: AppEnvironment.ci,
  );

  test('configures base URL, timeouts, and default headers', () {
    final container = ProviderContainer(
      overrides: [appConfigProvider.overrideWithValue(config)],
    );
    addTearDown(container.dispose);

    final dio = container.read(dioProvider);

    expect(dio.options.baseUrl, config.apiBaseUrl);
    expect(dio.options.connectTimeout, ApiClientDefaults.connectTimeout);
    expect(dio.options.receiveTimeout, ApiClientDefaults.receiveTimeout);
    expect(dio.options.sendTimeout, ApiClientDefaults.sendTimeout);
    expect(dio.options.headers['Accept'], 'application/json');
  });

  test('allows apps to add common headers without changing the client', () {
    final container = ProviderContainer(
      overrides: [
        appConfigProvider.overrideWithValue(config),
        commonHeadersProvider.overrideWithValue(
          (config) => {'Accept': 'application/json', 'X-App': config.appName},
        ),
      ],
    );
    addTearDown(container.dispose);

    final dio = container.read(dioProvider);

    expect(dio.options.headers['X-App'], 'Client App');
  });

  test('adds authorization header only when an auth token is provided', () {
    final container = ProviderContainer(
      overrides: [
        appConfigProvider.overrideWithValue(config),
        authTokenProvider.overrideWithValue('test-token'),
      ],
    );
    addTearDown(container.dispose);

    final dio = container.read(dioProvider);
    final options = RequestOptions(path: '/status');

    dio.interceptors.whereType<InterceptorsWrapper>().single.onRequest(
      options,
      RequestInterceptorHandler(),
    );

    expect(options.headers['Authorization'], 'Bearer test-token');
  });

  test('maps Dio errors through an overridable extension point', () {
    final original = DioException(
      requestOptions: RequestOptions(path: '/status'),
      type: DioExceptionType.connectionTimeout,
    );
    final mapped = DioException(
      requestOptions: original.requestOptions,
      type: DioExceptionType.unknown,
    );
    final container = ProviderContainer(
      overrides: [
        appConfigProvider.overrideWithValue(config),
        apiErrorMapperProvider.overrideWithValue((error) => mapped),
      ],
    );
    addTearDown(container.dispose);

    final mapper = container.read(apiErrorMapperProvider);

    expect(mapper(original), same(mapped));
  });
}
