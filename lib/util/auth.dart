import 'dart:convert';
import 'package:flutter_testing/settings/settings_bloc.dart';
import 'package:get_it/get_it.dart';

class Auth {
  String? token;
  int? userId;
  AppThemes? themeChoice;
  // final _storage = FlutterSecureStorage();

  // Future<SimpleLoginResponse> login(String username, String password) async {
  //   final uri = GetIt.I<ApiConfigData>().buildEndpointUri('login');
  //
  //   ApiCallResponse response = await GetIt.I<ApiHelper>()
  //       .post(uri, jsonEncode(SimpleLoginRequest(username, password).toMap()));
  //
  //   token = response.data['token'];
  //   userId = response.data['user']['id'];
  //   currentUser = User.fromJson(response.data['user']);
  //
  //   if (fcmToken != null) {
  //     updateFcm(fcmToken!);
  //   }
  //
  //   return SimpleLoginResponse(
  //       User.fromJson(response.data['user']), response.data['token']);
  // }

}

class SimpleLoginRequest {
  late String username;
  late String password;
  // ignore: non_constant_identifier_names
  late String grant_type;

  SimpleLoginRequest(this.username, this.password) {
    grant_type = 'password';
  }

  Map toMap() {
    var map = <String, dynamic>{};
    map['username'] = username;
    map['password'] = password;
    map['grant_type'] = grant_type;
    return map;
  }
}

class SimpleLoginResponse {
  dynamic user;
  String token;

  SimpleLoginResponse(this.user, this.token);
}
