import 'package:http_network/exceptions.dart';
import 'package:http/http.dart' as http;
import 'response_handle.dart';
import 'status_message.dart';

ResponseHandle handleResponse(http.Response response) {
  if (response.statusCode >= 200 && response.statusCode < 300 || response.statusCode >= 300 && response.statusCode < 400) {
    return ResponseHandle(
      statusCode: response.statusCode,
      body: response.body,
      message: statusCodeMessages[response.statusCode] ?? '',
    );
  } else if (response.statusCode >= 400 && response.statusCode < 500) {
    throw ClientErrorException(
      statusCode: response.statusCode,
      body: response.body,
      message: statusCodeMessages[response.statusCode] ?? '',
    );
  } else if (response.statusCode >= 500 && response.statusCode < 600) {
    throw ServerErrorException(
      statusCode: response.statusCode,
      body: response.body,
      message: statusCodeMessages[response.statusCode] ?? '',
    );
  } else {
    throw UnknownErrorException(
      statusCode: response.statusCode,
      body: response.body,
      message: statusCodeMessages[response.statusCode] ?? '',
    );
  }
}
