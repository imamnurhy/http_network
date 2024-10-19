part of 'package:http_network/http_network.dart';

class HttpRequest {
  Future<HttpResponse> request(
    String url, {
    HttpMethod method = HttpMethod.GET,
    Map<String, String> headers = const {},
    dynamic body = const {},
    Map<String, dynamic>? files,
    Function(int bytes, int totalBytes)? progressCallback,
  }) async {
    final Uri uri = Uri.parse(url);
    final bool isMultiPartRequest = files != null;

    late http.Response response;

    try {
      switch (method) {
        case HttpMethod.GET:
          response = await http.get(uri, headers: headers);
          break;
        case HttpMethod.POST:
        case HttpMethod.PATCH:
          response = isMultiPartRequest
              ? await _sendMultipartRequest(method, uri, headers, body, files, progressCallback)
              : await _sendRegularRequest(method, uri, headers, body);
          break;
        case HttpMethod.DELETE:
          response = await http.delete(uri, headers: headers);
          break;
        default:
          throw ArgumentError('Request Error: HTTP Method Not Defined!!');
      }

      return _handleResponse(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> _sendMultipartRequest(
    HttpMethod method,
    Uri uri,
    Map<String, String> headers,
    dynamic body,
    Map<String, dynamic> files,
    Function(int bytes, int total)? progressCallback,
  ) async {
    final String requestMethod = method == HttpMethod.POST ? 'POST' : 'PATCH';
    final MultipartRequest request = MultipartRequest(
      requestMethod,
      uri,
      onProgress: (bytes, total) => progressCallback?.call(bytes, total),
    );

    // Add header to request
    request.headers.addAll(headers);

    // Stringify body
    Map<String, String> stringifiedBody = Map<String, String>.from(
      body.map(
        (key, value) => MapEntry(
          key.toString(),
          value.toString(),
        ),
      ),
    );

    // Add field to reqeust
    request.fields.addAll(stringifiedBody);

    // Add files to the request
    for (var entry in files.entries) {
      final key = entry.key;
      final value = entry.value;

      if (value is List<String>) {
        for (var path in value) {
          request.files.add(await http.MultipartFile.fromPath(key, path));
        }
      } else if (value is String) {
        request.files.add(await http.MultipartFile.fromPath(key, value));
      } else {
        throw ArgumentError('Invalid file type for key $key, Expected String or List<String>.');
      }
    }

    final http.StreamedResponse streamedResponse = await request.send();
    return await http.Response.fromStream(streamedResponse);
  }

  Future<http.Response> _sendRegularRequest(
    HttpMethod method,
    Uri uri,
    Map<String, String> headers,
    dynamic body,
  ) async {
    switch (method) {
      case HttpMethod.POST:
        return await http.post(uri, headers: headers, body: body);
      case HttpMethod.PATCH:
        return await http.patch(uri, headers: headers, body: body);
      default:
        throw ArgumentError('Invalid method for regular request.');
    }
  }

  HttpResponse _handleResponse(http.Response response) {
    if (response.statusCode >= 100 && response.statusCode < 200) {
      throw InformationalException(response.statusCode, 'Informational response received');
    } else if (response.statusCode >= 200 && response.statusCode < 300) {
      return HttpResponse(
        statusCode: response.statusCode,
        body: response.body,
        bodyBytes: response.bodyBytes,
        headers: response.headers,
      );
    } else if (response.statusCode >= 300 && response.statusCode < 400) {
      String location = response.headers['location'] ?? 'Redirection without location';
      throw RedirectionException(response.statusCode, 'Redirection to $location');
    } else if (response.statusCode >= 400 && response.statusCode < 500) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      throw ClientException(response.statusCode, json.encode(jsonResponse));
    } else if (response.statusCode >= 500 && response.statusCode < 600) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      throw ServerException(response.statusCode, json.encode(jsonResponse));
    } else {
      throw UnknownStatusCodeException(response.statusCode, 'Unexpected status code: ${response.statusCode}');
    }
  }
}
