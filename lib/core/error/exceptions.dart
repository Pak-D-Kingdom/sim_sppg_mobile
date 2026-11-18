class ServerException implements Exception {
  final String message;
  final int? statusCode;

  const ServerException({
    this.message = 'Terjadi kesalahan pada server',
    this.statusCode,
  });

  @override
  String toString() => 'ServerException: $message (code: $statusCode)';
}

class CacheException implements Exception {
  final String message;

  const CacheException({this.message = 'Terjadi kesalahan pada cache lokal'});

  @override
  String toString() => 'CacheException: $message';
}

class NetworkException implements Exception {
  final String message;

  const NetworkException({
    this.message = 'Koneksi internet bermasalah. Periksa koneksi Anda.',
  });

  @override
  String toString() => 'NetworkException: $message';
}
