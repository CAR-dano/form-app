class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic responseData;

  ApiException({
    required this.message,
    this.statusCode,
    this.responseData,
  });

  @override
  String toString() {
    if (statusCode != null) {
      return 'ApiException ($statusCode): $message';
    }
    return 'ApiException: $message';
  }
}
