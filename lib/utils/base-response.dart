import 'package:calendar/index.dart';
import 'package:http/http.dart' as http;

class BaseResponse {
  final String message;
  final bool isSuccess;

  BaseResponse({
    this.message,
    this.isSuccess = false,
  });
}

class HTTPBaseResponse {
  bool success;
  Map body;
  int statusCode;

  HTTPBaseResponse({this.success, this.body, this.statusCode});

  factory HTTPBaseResponse.fromJson(http.Response res) {
    final response = json.decode(res.body) as Map<String, dynamic>;
    Map _body;
    bool status = false;
    if (res.statusCode == 200) {
      status = true;
      _body = response;
    } else {
    }
    return HTTPBaseResponse(
      success: status,
      statusCode: res.statusCode,
      body: _body,
    );
  }
}
