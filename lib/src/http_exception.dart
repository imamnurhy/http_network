part of 'package:http_network/http_network.dart';

class ClientException implements Exception {
  ClientException(this.error);
  final String error;
}

class ServerException implements Exception {
  ServerException(this.error);
  final String error;
}
