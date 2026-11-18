import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final int? statusCode;

  const Failure({required this.message, this.statusCode});

  @override
  List<Object?> get props => [message, statusCode];
}

class ServerFailure extends Failure {
  const ServerFailure({
    super.message = 'Terjadi kesalahan pada server. Silakan coba beberapa saat lagi.',
    super.statusCode,
  });
}

class CacheFailure extends Failure {
  const CacheFailure({
    super.message = 'Gagal mengakses data penyimpanan lokal.',
  });
}

class NetworkFailure extends Failure {
  const NetworkFailure({
    super.message = 'Tidak dapat terhubung ke jaringan. Periksa koneksi internet Anda.',
  });
}

class UnknownFailure extends Failure {
  const UnknownFailure({
    super.message = 'Terjadi kesalahan yang tidak terduga.',
  });
}
