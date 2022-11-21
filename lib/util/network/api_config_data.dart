class ApiConfigData {
  static var baseUrl;
  late String appEnv;

  ApiConfigData(String env) {
    appEnv = env;
    if (appEnv == 'prod') {
      baseUrl = 'copes.app:3003';
    } else {
      // baseUrl = '10.0.2.2:3000';
      baseUrl = '127.0.0.1:3000';
    }
  }

  Uri buildEndpointUri(String ep) {
    if (appEnv == 'local') {
      return Uri.http(baseUrl, ep);
    } else {
      return Uri.https(baseUrl, ep);
    }
  }
}
