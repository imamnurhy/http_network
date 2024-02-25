part of 'package:http_network/http_network.dart';

class ResponseHandle {
  String handle(int statusCode, String body) {
    if (statusCode >= 200 && statusCode < 400) {
      return body;
    } else if (statusCode >= 400 && statusCode < 500) {
      throw ClientException(statusCode, body);
    } else if (statusCode >= 500 && statusCode < 600) {
      throw ServerException(statusCode, body);
    } else {
      throw Exception(body);
    }
  }
}
