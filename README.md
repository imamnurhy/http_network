<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

# Http Network

Pakcage for handle reqeusts to restful api with handle error and response.

## Features

1. GET
2. POST
3. PATCH
4. DELETE
## Usage

1. Import this package.
2. Create an instance of HttpNetwork.
3. Use the instance to make HTTP requests.

```dart
import 'package:http_network/http_network.dart';
final HttpNetwork network = HttpNetwork();
final response = await network.get('https://mock.codes/200');
```
