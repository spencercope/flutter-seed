import 'dart:io';
import 'package:flutter_testing/util/auth.dart';
import 'package:flutter_testing/util/logging/logger.dart';
import 'package:flutter_testing/util/network/networking_models.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http/http.dart';

// todo figure out generics so we can call fromJson for a given type?
class ApiHelper {
  Future<ApiCallResponse> post<T>(Uri uri, String encodedjson,
      {bool expectList = false}) async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
    };
    if (GetIt.I<Auth>().token != null) {
      requestHeaders.putIfAbsent('Authorization', () {
        return 'Bearer ${GetIt.I<Auth>().token!}';
      });
    }

    Response? response;
    try {
      appLogger(
        uri.toString(),
        tag: '--> api helper - uri',
      );
      appLogger(
        requestHeaders.toString(),
        tag: '--> api helper - headers',
      );
      appLogger(
        encodedjson.toString(),
        tag: '--> api helper - posting body',
      );
      response =
          await http.post(uri, headers: requestHeaders, body: encodedjson);
      appLogger(
        response.statusCode.toString(),
        tag: '<-- api helper - status',
      );
      appLogger(
        response.headers.toString(),
        tag: '<-- api helper - headers',
      );
      prettyPrintJson(response.body);
    } catch (e) {
      appLogger(
        e.toString(),
        tag: 'api error',
      );
      if (response != null) {
        throw ApiException(response.reasonPhrase, response.statusCode);
      } else {
        throw ApiException('No Response', 0);
      }
    }
    if (is2xx(response)) {
      var data = await json.decode(response.body);
      if (expectList) {
        return ApiCallListResponse(response.statusCode, listData: data);
      } else {
        return ApiCallObjectResponse(response.statusCode, data: data);
      }
    }
    throw ApiException('Something went wrong.', 0);
  }

  Future<ApiCallResponse> put<T>(Uri uri, String encodedjson,
      {bool expectList = false}) async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
    };
    if (GetIt.I<Auth>().token != null) {
      requestHeaders.putIfAbsent('Authorization', () {
        return 'Bearer ${GetIt.I<Auth>().token!}';
      });
    }

    Response? response;
    try {
      appLogger(
        uri.toString(),
        tag: '--> api helper - uri',
      );
      appLogger(
        requestHeaders.toString(),
        tag: '--> api helper - headers',
      );
      appLogger(
        encodedjson.toString(),
        tag: '--> api helper - put body',
      );
      response =
          await http.put(uri, headers: requestHeaders, body: encodedjson);
      appLogger(
        response.statusCode.toString(),
        tag: '<-- api helper - status',
      );
      appLogger(
        response.headers.toString(),
        tag: '<-- api helper - headers',
      );
      prettyPrintJson(response.body);
    } catch (e) {
      appLogger(
        e.toString(),
        tag: 'api error',
      );
      if (response != null) {
        throw ApiException(response.reasonPhrase, response.statusCode);
      }
    }
    if (response != null && is2xx(response)) {
      var data = await json.decode(response.body);
      if (expectList) {
        return ApiCallListResponse(response.statusCode, listData: data);
      } else {
        return ApiCallObjectResponse(response.statusCode, data: data);
      }
    }
    throw ApiException('Something went wrong.', 0);
  }

  Future<ApiCallResponse> get<T>(Uri uri, {bool expectList = false}) async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
    };
    if (GetIt.I<Auth>().token != null) {
      requestHeaders.putIfAbsent('Authorization', () {
        return 'Bearer ${GetIt.I<Auth>().token!}';
      });
    }

    Response? response;
    try {
      appLogger(
        uri.toString(),
        tag: '--> api helper - uri',
      );
      appLogger(
        requestHeaders.toString(),
        tag: '--> api helper - headers',
      );
      response = await http.get(uri, headers: requestHeaders);
      appLogger(
        response.statusCode.toString(),
        tag: '<-- api helper - status',
      );
      appLogger(
        response.headers.toString(),
        tag: '<-- api helper - headers',
      );
      if (response.body.isNotEmpty) {
        prettyPrintJson(response.body);
      }
    } catch (e) {
      appLogger(
        e.toString(),
        tag: 'api error',
      );
      if (response != null) {
        throw ApiException(response.reasonPhrase, response.statusCode);
      }
    }
    if (response != null && is2xx(response)) {
      var data;
      if (response.body.isNotEmpty) {
        data = await json.decode(response.body);
      } else {
        data = {};
      }
      if (expectList) {
        return ApiCallListResponse(response.statusCode, listData: data);
      } else {
        return ApiCallObjectResponse(response.statusCode, data: data);
      }
    }
    throw ApiException('Something went wrong.', 0);
  }
}

void prettyPrintJson(String input) {
  JsonDecoder decoder = const JsonDecoder();
  JsonEncoder encoder = const JsonEncoder.withIndent('  ');
  var object = decoder.convert(input);
  var prettyString = encoder.convert(object);
  prettyString.split('\n').forEach((element) => appLogger(element));
}

bool is2xx(Response response) {
  if ([200, 201].contains(response.statusCode)) {
    return true;
  }
  return false;
}
