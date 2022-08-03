import 'dart:developer';

import 'package:flutter_test/flutter_test.dart';
import 'package:http_network/http_network.dart';

void main() {
  final HttpNetwork network = HttpNetwork();

  group('Http Network GET', () {
    test('Test Success', () async {
      try {
        final response = await network.get('https://mock.codes/200');
        log(response.body);
      } on ClientErrorException catch (e) {
        log(e.toString());
        log('Status Code : ${e.statusCode}');
        log('Body : ${e.body}');
        log('Message : ${e.message}');
        expect(e, isA<ClientErrorException>());
      } on ServerErrorException catch (e) {
        log(e.toString());
        log('Status Code : ${e.statusCode}');
        log('Body : ${e.body}');
        log('Message : ${e.message}');
        expect(e, isA<ServerErrorException>());
      } on UnknownErrorException catch (e) {
        log(e.toString());
        log('Status Code : ${e.statusCode}');
        log('Body : ${e.body}');
        log('Message : ${e.message}');
        expect(e, isA<UnknownErrorException>());
      } catch (e) {
        log(e.toString());
        expect(e, isA<Exception>());
      }
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
