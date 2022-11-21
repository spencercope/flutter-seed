
abstract class ApiCallResponse {
  int status;
  dynamic data;
  dynamic listData;
  ApiCallResponse(this.status, this.data, this.listData);
}

class ApiCallObjectResponse extends ApiCallResponse {
  @override
  int status;
  @override
  dynamic data;

  ApiCallObjectResponse(this.status, {this.data}) : super(status, data, null);
}

class ApiCallListResponse extends ApiCallResponse {
  @override
  int status;
  @override
  dynamic listData;

  ApiCallListResponse(this.status, {this.listData}) : super(status, null, listData);
}


class ApiException implements Exception {
  String? cause;
  int? status;
  ApiException(this.cause, this.status);
}
