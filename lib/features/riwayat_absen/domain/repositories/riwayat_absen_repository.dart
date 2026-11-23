import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/riwayat_absen_data.dart';

abstract class RiwayatAbsenRepository {
  Future<Either<Failure, RiwayatAbsenData>> getRiwayatAbsen({
    required int month,
    required int year,
  });
}
