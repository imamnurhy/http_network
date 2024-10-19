library http_network;

import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

part 'src/http_exception.dart';
part 'src/response_handle.dart';
part 'src/http_request.dart';
part 'src/http_method.dart';
part 'src/http_response.dart';
part 'src/multipart_request.dart';

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
  Future<HttpResponse> get(
    String url, {
    Map<String, String> headers = const {},
  }) async {
    try {
      final HttpResponse response = await HttpRequest().request(url, headers: headers);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<HttpResponse> post(
    String url, {
    Map<String, String> headers = const {},
    dynamic body = const {},
    Map<String, dynamic>? files,
    Function(int bytes, int totalBytes)? progressCallback,
  }) async {
    try {
      final HttpResponse response = await HttpRequest().request(
        url,
        method: HttpMethod.POST,
        headers: headers,
        body: body,
        files: files,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<HttpResponse> patch(
    String url, {
    Map<String, String> headers = const {},
    dynamic body = const {},
    Map<String, dynamic>? files,
    Function(int bytes, int totalBytes)? progressCallback,
  }) async {
    try {
      final HttpResponse response = await HttpRequest().request(
        url,
        method: HttpMethod.PATCH,
        headers: headers,
        body: body,
        files: files,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<HttpResponse> delete(
    String url, {
    Map<String, String> headers = const {},
  }) async {
    try {
      final HttpResponse response = await HttpRequest().request(
        url,
        method: HttpMethod.DELETE,
        headers: headers,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
