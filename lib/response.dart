part of 'http_network.dart';

class Response {
  Response({
    this.statusCode,
    this.body,
    this.message,
  });

  final int statusCode;
  final String body;
  final String message;
}
