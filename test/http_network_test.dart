import 'dart:developer';

import 'package:flutter_test/flutter_test.dart';
import 'package:http_network/exceptions.dart';
import 'package:http_network/http_network.dart';

void main() {
  final HttpNetwork network = HttpNetwork();

  group('Http Network GET', () {
    test('Test Success', () async {
      final response = await network.get('https://mock.codes/200');
      expect(response.statusCode, 200);
    });

    test('Test Client Error', () async {
      try {
        await network.get('https://mock.codes/404');
      } on ClientErrorException catch (e) {
        expect(e.statusCode, 404);
      }
    });

    test('Test Server Error', () async {
      try {
        await network.get('https://mock.codes/500');
      } on ServerErrorException catch (e) {
        expect(e.statusCode, 500);
      }
    });
  });

  group('Http Network POST', () {
    test('Test Create New Data', () async {
      final response = await network.post('https://mock.codes/201');
      expect(response.statusCode, 201);
    });

    test('Test Client Error', () async {
      try {
        await network.post('https://mock.codes/404');
      } on ClientErrorException catch (e) {
        expect(e.statusCode, 404);
      }
    });

    test('Test Server Error', () async {
      try {
        await network.post('https://mock.codes/500');
      } on ServerErrorException catch (e) {
        expect(e.statusCode, 500);
      }
    });
  });
}
