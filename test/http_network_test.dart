import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http_network/http_network.dart';

void main() {
  HttpNetwork network = HttpNetwork();

  group('Http Network GET', () {
    test('Test Success', () async {
      final response = await network.get('https://mock.codes/200');
      final body = json.decode(response.body);
      expect(body['statusCode'], 200);
    });

    test('Test Client Error', () async {
      try {
        await network.get('https://mock.codes/404');
      } on ClientException catch (e) {
        expect(json.decode(e.error)['statusCode'], 404);
      }
    });

    test('Test Server Error', () async {
      try {
        await network.get('https://mock.codes/500');
      } on ServerException catch (e) {
        expect(json.decode(e.error)['statusCode'], 500);
      }
    });
  });
}
