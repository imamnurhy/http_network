library http_network;

import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;

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
  Future<Response> get(
    String url, {
    Map<String, String> headers = const {},
    bool logs = false,
  }) async {
    try {
      final http.Response response = await http.get(
        Uri.parse(url),
        headers: headers,
      );
      if (logs) log(response.body);

      return handle(response);
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
    Map<String, String> body = const {},
    Map<String, String> files = const {},
    bool logs = false,
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
            filename: key,
          ));
        });
        var streamedResponse = await request.send();
        var response = await http.Response.fromStream(streamedResponse);
        if (logs) log(response.body);
        return handle(response);
      } else {
        final response = await http.post(Uri.parse(url));
        if (logs) log(response.body);
        return handle(response);
      }
    } on TimeoutException catch (e) {
      throw e.toString();
    } on SocketException catch (e) {
      throw e.message;
    } on FormatException catch (e) {
      throw e.message;
    } on ClientErrorException catch (e) {
      rethrow;
    } on ServerErrorException catch (e) {
      rethrow;
    } on Exception catch (e) {
      throw e.toString();
    }
  }

  Future<Response> patch(
    String url, {
    Map<String, String> headers = const {},
    Map<String, String> body = const {},
    Map<String, String> files = const {},
    bool logs = false,
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
        if (logs) log(response.body);
        return handle(response);
      } else {
        final response = await http.patch(Uri.parse(url));
        if (logs) log(response.body);
        return handle(response);
      }
    } on TimeoutException catch (e) {
      throw e.toString();
    } on SocketException catch (e) {
      throw e.message;
    } on FormatException catch (e) {
      throw e.message;
    } on ClientErrorException catch (e) {
      rethrow;
    } on ServerErrorException catch (e) {
      rethrow;
    } on Exception catch (e) {
      throw e.toString();
    }
  }

  Future<Response> delete(
    String url, {
    Map<String, String> headers = const {},
    bool logs = false,
  }) async {
    try {
      final http.Response response = await http.delete(
        Uri.parse(url),
        headers: headers,
      );
      if (logs) log(response.body);
      return handle(response);
    } on TimeoutException catch (e) {
      throw e.toString();
    } on SocketException catch (e) {
      throw e.message;
    } on FormatException catch (e) {
      throw e.message;
    } on ClientErrorException catch (e) {
      rethrow;
    } on ServerErrorException catch (e) {
      rethrow;
    } on Exception catch (e) {
      throw e.toString();
    }
  }

  // Handle response
  Response handle(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 400) {
      return Response(
        statusCode: response.statusCode,
        body: response.body,
      );
    } else if (response.statusCode >= 400 && response.statusCode < 500) {
      throw ClientErrorException(
        statusCode: response.statusCode,
        body: response.body,
      );
    } else if (response.statusCode >= 500 && response.statusCode < 600) {
      throw ServerErrorException(
        statusCode: response.statusCode,
        body: response.body,
      );
    } else {
      throw UnknownErrorException(
        statusCode: response.statusCode,
        body: response.body,
      );
    }
  }
}
