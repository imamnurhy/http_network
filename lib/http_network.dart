library http_network;

import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;

part 'src/http_exception.dart';
part 'src/response_handle.dart';
part 'src/http_request.dart';
part 'src/http_method.dart';

/// Package Http Network
/// ---
/// This package is used to make HTTP requests.
///
/// ---
/// Usage:
/// 1. Import this package.
/// 2. Create an instance of HttpNetwork.
/// 3. Use the instance to make HTTP requests.
/// ---
/// Example:
/// ```dart
/// import 'package:http_network/http_network.dart';
/// final HttpNetwork network = HttpNetwork();
/// final response = await network.get('https://mock.codes/200');
/// ```
/// ---
///
/// @athor: Imamnurhy
///
/// ---
class HttpNetwork {
  final HttpRequest _httpRequest = HttpRequest();
  Future<String> get(
    String url, {
    Map<String, String> headers = const {},
  }) async {
    try {
      return _httpRequest.request(url, headers: headers);
    } catch (e) {
      rethrow;
    }
  }

  Future<String> post(
    String url, {
    Map<String, String> headers = const {},
    dynamic body = const {},
    Map<String, String> files = const {},
  }) async {
    try {
      return _httpRequest.request(
        url,
        method: HttpMethod.POST,
        headers: headers,
        body: body,
        files: files,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<String> patch(
    String url, {
    Map<String, String> headers = const {},
    dynamic body = const {},
    Map<String, String> files = const {},
  }) async {
    try {
      return _httpRequest.request(
        url,
        method: HttpMethod.PATCH,
        headers: headers,
        body: body,
        files: files,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<String> delete(
    String url, {
    Map<String, String> headers = const {},
  }) async {
    try {
      return _httpRequest.request(url, method: HttpMethod.DELETE, headers: headers);
    } catch (e) {
      rethrow;
    }
  }
}
