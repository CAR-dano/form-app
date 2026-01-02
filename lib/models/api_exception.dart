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
    final buffer = StringBuffer();
    
    if (statusCode != null) {
      buffer.write('ApiException ($statusCode): $message');
    } else {
      buffer.write('ApiException: $message');
    }
    
    // Include response data if available
    if (responseData != null) {
      buffer.write(' [Response: $responseData]');
    }
    
    return buffer.toString();
  }
}
