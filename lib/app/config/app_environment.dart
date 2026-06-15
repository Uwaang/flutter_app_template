enum AppEnvironment {
  ci,
  dev,
  stage,
  prod;

  bool get isProduction => this == AppEnvironment.prod;

  static AppEnvironment fromValue(String value) {
    switch (value.trim().toLowerCase()) {
      case 'ci':
        return AppEnvironment.ci;
      case 'dev':
      case 'development':
        return AppEnvironment.dev;
      case 'prod':
      case 'production':
        return AppEnvironment.prod;
      case 'stage':
      case 'staging':
        return AppEnvironment.stage;
      default:
        throw ArgumentError.value(
          value,
          'APP_ENV',
          'Expected one of: ci, dev, development, stage, staging, prod, production.',
        );
    }
  }
}
