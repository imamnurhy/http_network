part of 'package:http_network/http_network.dart';

class MultipartRequest extends http.MultipartRequest {
  /// Creates a new [MultipartRequest].
  MultipartRequest(
    String method,
    Uri url, {
    this.onProgress,
  }) : super(method, url);

  final void Function(int bytes, int totalBytes)? onProgress;

  /// Freezes all mutable fields and returns a
  /// single-subscription [http.ByteStream]
  /// that will emit the request body.
  @override
  http.ByteStream finalize() {
    final byteStream = super.finalize();

    if (onProgress == null) return byteStream;

    final totalBytes = contentLength;
    int bytesTransferred = 0;

    final transformedStream = StreamTransformer.fromHandlers(
      handleData: (List<int> chunk, EventSink<List<int>> sink) {
        bytesTransferred += chunk.length;
        onProgress?.call(bytesTransferred, totalBytes);
        sink.add(chunk);
      },
    );

    return http.ByteStream(byteStream.transform(transformedStream));
  }
}
