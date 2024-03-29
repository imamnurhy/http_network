part of 'package:http_network/http_network.dart';

class HttpRequest {
  final _responseHandle = ResponseHandle();

  Future<String> request(
    String url, {
    HttpMethod method = HttpMethod.GET,
    Map<String, String> headers = const {},
    dynamic body = const {},
    Map<String, String> files = const {},
  }) async {
    try {
      if (method == HttpMethod.GET) {
        final http.Response response = await http.get(Uri.parse(url), headers: headers);
        return _responseHandle.handle(response.statusCode, response.body);
      }

      if (method == HttpMethod.POST || method == HttpMethod.PATCH) {
        if (files.isNotEmpty) {
          String httpMultipartRequestMethod = method == HttpMethod.POST ? 'POST' : 'PATCH';

          final request = http.MultipartRequest('POST', Uri.parse(url));

          request.headers.addAll(headers);
          request.fields.addAll(body);
          request.fields['_method'] = httpMultipartRequestMethod;

          files.forEach((key, value) async {
            request.files.add(await http.MultipartFile.fromPath(
              key,
              value,
              filename: value.split('/').last,
            ));
          });
          var streamedResponse = await request.send();
          var response = await http.Response.fromStream(streamedResponse);
          return _responseHandle.handle(response.statusCode, response.body);
        } else {
          http.Response response;
          method == HttpMethod.POST
              ? response = await http.post(
                  Uri.parse(url),
                  headers: headers,
                  body: body,
                )
              : response = await http.patch(
                  Uri.parse(url),
                  headers: headers,
                  body: body,
                );
          return _responseHandle.handle(response.statusCode, response.body);
        }
      }

      if (method == HttpMethod.DELETE) {
        final http.Response response = await http.delete(
          Uri.parse(url),
          headers: headers,
        );
        return _responseHandle.handle(response.statusCode, response.body);
      }
      throw Exception('Request Error : HTTP Method Not Defined!!');
    } catch (e) {
      rethrow;
    }
  }
}
