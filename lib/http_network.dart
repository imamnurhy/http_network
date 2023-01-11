library http_network;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

import 'package:http_network/http_status_code.dart';

part 'response.dart';
part 'exceptions.dart';

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
  const HttpNetwork({
    this.logs = false,
  });

  final bool logs;

  Future<Response> get(
    String url, {
    Map<String, String> headers = const {},
  }) async {
    try {
      final http.Response response = await http.get(Uri.parse(url), headers: headers);
      _log(response); // Make log request
      return _handle(response);
    } on TimeoutException catch (e) {
      throw e.message.toString();
    } on SocketException catch (e) {
      throw e.message;
    } on FormatException catch (e) {
      throw e.message;
    } on Exception {
      rethrow;
    }
  }

  Future<Response> post(
    String url, {
    Map<String, String> headers = const {},
    dynamic body = const {},
    Map<String, String> files = const {},
  }) async {
    try {
      if (files.isNotEmpty) {
        final request = http.MultipartRequest('POST', Uri.parse(url));
        request.headers.addAll(headers);
        request.fields.addAll(body);
        files.forEach((key, value) async {
          request.files.add(await http.MultipartFile.fromPath(
            key,
            value,
            filename: value.split('/').last,
          ));
        });
        var streamedResponse = await request.send();
        var response = await http.Response.fromStream(streamedResponse);

        _log(response, body: body, files: files); // Make log request

        return _handle(response);
      } else {
        final response = await http.post(
          Uri.parse(url),
          headers: headers,
          body: body,
        );

        _log(response, body: body); // Make log request

        return _handle(response);
      }
    } on TimeoutException catch (e) {
      throw e.toString();
    } on SocketException catch (e) {
      throw e.message;
    } on FormatException catch (e) {
      throw e.message;
    } on Exception {
      rethrow;
    }
  }

  Future<Response> patch(
    String url, {
    Map<String, String> headers = const {},
    dynamic body = const {},
    Map<String, String> files = const {},
  }) async {
    try {
      if (files.isNotEmpty) {
        final request = http.MultipartRequest('PATCH', Uri.parse(url));
        request.headers.addAll(headers);
        request.fields.addAll(body);
        files.forEach((key, value) async {
          request.files.add(await http.MultipartFile.fromPath(
            key,
            value,
            filename: key,
          ));
        });
        var streamedResponse = await request.send();
        var response = await http.Response.fromStream(streamedResponse);

        _log(response, body: body, files: files); // Make log request

        return _handle(response);
      } else {
        final response = await http.patch(
          Uri.parse(url),
          headers: headers,
          body: body,
        );

        _log(response, body: body); // Make log request

        return _handle(response);
      }
    } on TimeoutException catch (e) {
      throw e.toString();
    } on SocketException catch (e) {
      throw e.message;
    } on FormatException catch (e) {
      throw e.message;
    } on Exception {
      rethrow;
    }
  }

  Future<Response> delete(
    String url, {
    Map<String, String> headers = const {},
  }) async {
    try {
      final http.Response response = await http.delete(
        Uri.parse(url),
        headers: headers,
      );

      _log(response); // Make log request

      return _handle(response);
    } on TimeoutException catch (e) {
      throw e.toString();
    } on SocketException catch (e) {
      throw e.message;
    } on FormatException catch (e) {
      throw e.message;
    } on Exception {
      rethrow;
    }
  }

  // Handle response
  Response _handle(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 400) {
      return Response(
        statusCode: response.statusCode,
        message: statusMessages['${response.statusCode}'],
        body: response.body,
      );
    } else if (response.statusCode >= 400 && response.statusCode < 500) {
      throw ClientErrorException(
        statusCode: response.statusCode,
        message: statusMessages['${response.statusCode}'],
        body: response.body,
      );
    } else if (response.statusCode >= 500 && response.statusCode < 600) {
      throw ServerErrorException(
        statusCode: response.statusCode,
        message: statusMessages['${response.statusCode}'],
        body: response.body,
      );
    } else {
      throw UnknownErrorException(
        statusCode: response.statusCode,
        message: statusMessages['${response.statusCode}'],
        body: response.body,
      );
    }
  }

  // Create log
  void _log(
    http.Response response, {
    dynamic body = const {},
    Map<String, String> files = const {},
  }) {
    if (this.logs) {
      developer.log(
        '${response.request}',
        name: 'Http',
        error: json.encode({
          'code': response.statusCode,
          'datetime': DateTime.now().toIso8601String(),
          'body': body,
          'files': files,
          'response': json.decode(response.body)
        }),
      );
    } else {
      developer.log('${response.request}', name: 'Http');
    }
  }
}
