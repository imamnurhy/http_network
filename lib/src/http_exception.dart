part of 'package:http_network/http_network.dart';

class ClientException implements Exception {
  ClientException(this.statusCode, this.error);
  final int statusCode;
  final String error;
}

class ServerException implements Exception {
  ServerException(this.statusCode, this.error);
  final int statusCode;
  final String error;
}
