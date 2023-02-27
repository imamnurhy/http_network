# HTTP Network

Pakcage for handle reqeusts to restful api with handle error and response.

## Requirement 
1. FLutter SDK (2.10.5)

## How to install

Open your pubspec.yaml file and add the following line:

```
dependencies:
  http_network:
    git:
      url: url_to_repository
``` 

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
