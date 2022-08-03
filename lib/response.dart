class Response {
  Response({
    required this.statusCode,
    required this.body,
    this.message,
  });

  final int statusCode;
  final String body;
  final String? message;
}
