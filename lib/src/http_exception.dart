part of 'package:http_network/http_network.dart';

abstract class HttpException implements Exception {
  final int statusCode;
  final String message;

  HttpException(this.statusCode, this.message);

  @override
  String toString() {
    return 'HttpException(statusCode: $statusCode, message: $message)';
  }
}

class ClientException extends HttpException {
  final String error;

  ClientException(int statusCode, this.error) : super(statusCode, error);

  // @override
  // String toString() {
  //   return 'ClientException(statusCode: $statusCode, error: $error)';
  // }
}

class ServerException extends HttpException {
  final String error;

  ServerException(int statusCode, this.error) : super(statusCode, error);

  @override
  String toString() {
    return 'ServerException(statusCode: $statusCode, error: $error)';
  }
}

class InformationalException extends HttpException {
  InformationalException(int statusCode, String message) : super(statusCode, message);

  @override
  String toString() {
    return 'InformationalException(statusCode: $statusCode, message: $message)';
  }
}

class RedirectionException extends HttpException {
  RedirectionException(int statusCode, String message) : super(statusCode, message);

  @override
  String toString() {
    return 'RedirectionException(statusCode: $statusCode, message: $message)';
  }
}

class UnknownStatusCodeException extends HttpException {
  UnknownStatusCodeException(int statusCode, String message) : super(statusCode, message);

  @override
  String toString() {
    return 'UnknownStatusCodeException(statusCode: $statusCode, message: $message)';
  }
}
