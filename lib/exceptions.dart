part of 'http_network.dart';

/// Client Error Exception
/// ---
/// When error statu code server is 4xx.
///
/// ---
class ClientErrorException implements Exception {
  ClientErrorException({
    this.statusCode,
    this.body,
    this.message,
  });

  final int statusCode;
  final String body;
  final String message;
}

/// Client Error Exception
/// ---
/// When error statu code server is 5xx.
///
/// ---
class ServerErrorException implements Exception {
  ServerErrorException({
    this.statusCode,
    this.body,
    this.message,
  });

  final int statusCode;
  final String body;
  final String message;
}

/// Unknown Error Exception
/// ---
/// When error statu code server is 5xx.
///
/// ---
class UnknownErrorException implements Exception {
  UnknownErrorException({
    this.statusCode,
    this.body,
    this.message,
  });

  final int statusCode;
  final String body;
  final String message;
}
