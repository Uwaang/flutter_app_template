enum AppEnvironment {
  dev,
  stage,
  prod;

  bool get isProduction => this == AppEnvironment.prod;

  static AppEnvironment fromValue(String value) {
    switch (value.toLowerCase()) {
      case 'prod':
      case 'production':
        return AppEnvironment.prod;
      case 'stage':
      case 'staging':
        return AppEnvironment.stage;
      default:
        return AppEnvironment.dev;
    }
  }
}
