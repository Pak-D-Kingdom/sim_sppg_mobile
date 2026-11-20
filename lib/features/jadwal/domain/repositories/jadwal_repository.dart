import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/jadwal_data.dart';

abstract class JadwalRepository {
  Future<Either<Failure, JadwalData>> getJadwal({int? month, int? year});
}
