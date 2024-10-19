part of 'package:http_network/http_network.dart';

class HttpResponse {
  final int statusCode;
  final String body;
  final Uint8List bodyBytes;
  final Map<String, String> headers;

  HttpResponse({
    required this.statusCode,
    required this.body,
    required this.bodyBytes,
    required this.headers,
  });
}
