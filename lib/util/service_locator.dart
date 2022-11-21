import 'package:flutter_testing/util/network/api_config_data.dart';
import 'package:flutter_testing/util/network/base_api.dart';
import 'package:get_it/get_it.dart';

import 'auth.dart';

void setupLocator(String env) {
  GetIt.I.registerSingleton<Auth>(Auth());
  GetIt.I.registerSingleton<ApiConfigData>(ApiConfigData(env));
  GetIt.I.registerSingleton<ApiHelper>(ApiHelper());
}
